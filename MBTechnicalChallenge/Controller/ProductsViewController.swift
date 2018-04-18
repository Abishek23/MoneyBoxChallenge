//
//  ProductsViewController.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import UIKit
import Whisper
import SVProgressHUD

class ProductsViewController: UITableViewController {
    var selectedAccount: ProductElement?
    @IBOutlet weak var logoutOutlet: UIBarButtonItem!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBAction func logoutAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        
    
        self.navItem.hidesBackButton = true
   
        
        MBClient.sharedInstance().investorProductsRequest { (investorProducts, error) -> (Void) in
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
            
            if error != nil {
                DispatchQueue.main.sync {
                    let message = Message(title: "Error:\(String(describing: error?.localizedDescription))", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
                }
            }
            
            if let investorProducts = investorProducts {
                DispatchQueue.main.sync {
                    SVProgressHUD.dismiss()
               
                    MBClient.sharedInstance().investorProducts = investorProducts
                    self.tableView.reloadData()
                    print(MBClient.sharedInstance().investorProducts?.products)
                }
                
                print(investorProducts)
            } else {
                print("error occured")
                
                DispatchQueue.main.sync {
                    let message = Message(title: "Failed to retrieve investor products", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
                }
            
        }
        
  
    }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvestorProductCell", for: indexPath) as? InvestorProductCell else {
            return UITableViewCell()
        }
        guard let products = MBClient.sharedInstance().investorProducts?.products else {return UITableViewCell() }
         let product = products[indexPath.row]
        
        if product.investorProductType == "Isa" {
            cell.label.text = "Stocks and Shares ISA >"
        } else {
            cell.label.text = "General Investment Account >"
        }
        

        
        
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              guard let products = MBClient.sharedInstance().investorProducts?.products else {return 0 }
            return products.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let products = MBClient.sharedInstance().investorProducts?.products else {return}
        let selectedProduct = products[indexPath.row]
        self.selectedAccount = selectedProduct
        performSegue(withIdentifier: "ProductSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductViewController {
            guard let account = selectedAccount else {return }
            destination.selectedAccount = account
            
        }
    }
}

