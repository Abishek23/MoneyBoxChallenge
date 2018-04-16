//
//  ProductsViewController.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class ProductsViewController: UITableViewController {
   
    var products = [ProductElement]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvestorProductCell", for: indexPath) as? InvestorProductCell else {
            return UITableViewCell()
        }
         let product = products[indexPath.row]
         
        cell.label.text = product.investorProductType
        
        
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
}

