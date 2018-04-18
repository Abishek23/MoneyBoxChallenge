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
        guard let account = selectedAccount else {return}
        if account.investorProductType == "Isa" {
            self.navItem.title = "Stocks and Shares Isa"
        } else if account.investorProductType == "Gia" {
            navItem.title = "General Investment Account"
        }
        
          self.moneyboxLabel.text = "Your moneybox: £\(selectedAccount!.moneybox)"
        

        // Do any additional setup after loading the view.
    }
    @IBAction func incementMoneyBox(_ sender: UIButton) {
        
        
        
          guard let account = selectedAccount else {return}
        
        if account.maximumDeposit > MBConstants.APIParamterValue.fixedDeposit {
        
        MBClient.sharedInstance().oneOffPaymentRequest(amount: MBConstants.APIParamterValue.fixedDeposit, inverstorProductId: account.investorProductID) { (moneyBox, error) -> (Void) in
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
            if error != nil {
                DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    let message = Message(title: "Error:\(String(describing: error?.localizedDescription))", backgroundColor: .red)
                
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
        
                }
            }
            
            
            if let mb = moneyBox {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    let message = Message(title: "Deposit Success", backgroundColor: .red)
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
                           self.moneyboxLabel.text = "Your moneybox: £\(mb.moneybox)"
                }
                self.fetchInvestorProducts()
            }
   
          

       
            }
            
            
            
            
            } else {
            
            DispatchQueue.main.async {
               SVProgressHUD.dismiss()
                let message = Message(title: "Maximum deposit reached", backgroundColor: .red)
                Whisper.show(whisper: message, to: self.navigationController!, action: .show)
            }
            
            
            
        }
    }
    
    
    func fetchInvestorProducts(){
        MBClient.sharedInstance().investorProductsRequest { (investorProducts, error) -> (Void) in
            if error != nil {
                DispatchQueue.main.async {
                    let message = Message(title: "Error:\(String(describing: error?.localizedDescription))", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
                }
            }
            
            if let investorProducts = investorProducts {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    
                    MBClient.sharedInstance().investorProducts = investorProducts
                    for product in investorProducts.products {
                        if product.investorProductID == self.selectedAccount?.investorProductID {
                            self.selectedAccount = product
                            self.moneyboxLabel.text = "Your moneybox: \(self.selectedAccount!.moneybox)"
                        }
                    }
                    print(MBClient.sharedInstance().investorProducts?.products)
                }
                
                print(investorProducts)
            } else {
                print("error occured")
                
                DispatchQueue.main.async {
                    let message = Message(title: "Failed to refresh moneybox", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
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
