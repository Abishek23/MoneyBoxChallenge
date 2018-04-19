//
//  ViewController.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 18/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import UIKit
import SVProgressHUD
import Whisper
class ProductViewController: UIViewController {
    @IBOutlet weak var moneyboxLabel: UILabel!
    @IBOutlet weak var incrementMBOutlet: UIButton!
    var selectedAccount:ProductElement?
    @IBOutlet weak var navItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.hidesBackButton = false
        guard let account = selectedAccount else {return}
        if account.investorProductType == "Isa" {
            self.navItem.title = "Stocks and Shares Isa"
        } else if account.investorProductType == "Gia" {
            navItem.title = "General Investment Account"
        }
        self.moneyboxLabel.text = "Your moneybox: £\(selectedAccount!.moneybox)"
        
    }
    @IBAction func incementMoneyBox(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Confirm deposit", message: "Are you sure you want to deposit £\(MBConstants.APIParamterValue.fixedDeposit) into your moneybox?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let account = self.selectedAccount else {return}
            
            if account.maximumDeposit > MBConstants.APIParamterValue.fixedDeposit {
                
                MBClient.sharedInstance().oneOffPaymentRequest(amount: MBConstants.APIParamterValue.fixedDeposit, inverstorProductId: account.investorProductID) { (moneyBox, error) -> (Void) in
                    
                    if error != nil {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            let message = Message(title: "Error:\(String(describing: error?.localizedDescription))", backgroundColor: .red)
                            guard let navController = self.navigationController else {return }
                            Whisper.show(whisper: message, to: navController, action: .show)
                            
                        }
                    }
                    
                    
                    if let mb = moneyBox {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            let message = Message(title: "Deposit Success", backgroundColor: .red)
                            guard let navController = self.navigationController else {return }
                            Whisper.show(whisper: message, to: navController, action: .show)
                            self.moneyboxLabel.text = "Your moneybox: £\(mb.moneybox)"
                        }
                        self.fetchInvestorProducts()
                    }
                }
                
            } else {
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    let message = Message(title: "Maximum deposit reached", backgroundColor: .red)
                    guard let navController = self.navigationController else {return }
                    Whisper.show(whisper: message, to: navController, action: .show)                }
                
            }}))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func fetchInvestorProducts(){
        MBClient.sharedInstance().investorProductsRequest { (investorProducts, error) -> (Void) in
            if error != nil {
                DispatchQueue.main.async {
                    let message = Message(title: "Error:\(String(describing: error?.localizedDescription))", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    guard let navController = self.navigationController else {return }
                    Whisper.show(whisper: message, to: navController, action: .show)
                }
            }
            
            if let investorProducts = investorProducts {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    MBClient.sharedInstance().investorProducts = investorProducts
                    for product in investorProducts.products {
                        if product.investorProductID == self.selectedAccount?.investorProductID {
                            self.selectedAccount = product
                            self.moneyboxLabel.text = "Your moneybox: £\(self.selectedAccount!.moneybox)"
                        }
                    }
                    
                }
                
                print(investorProducts)
            } else {
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    let message = Message(title: "Failed to refresh moneybox", backgroundColor: .red)
                    guard let navController = self.navigationController else {return }
                    Whisper.show(whisper: message, to: navController, action: .show)
                }
                
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
