//
//  ProductsViewController.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
import Alamofire
class ProductsViewController: UIViewController, ListAdapterDataSource {
    var products = [Product]()
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        self.products
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return LabelSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    lazy var adapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
}
