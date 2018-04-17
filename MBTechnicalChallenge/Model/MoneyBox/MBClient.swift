//
//  MBClient.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import Alamofire
import AdSupport
class MBClient : NSObject {
    // MARK: Properties
    
    //authentication state
    var userInformation:UserInformation? = nil
    
    var idfa:String? = nil
    
    func getIdfa() -> String {

        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }

//    func login(email:String, password:String, completion:@escaping (UserInformation?) -> Void) {
//        Alamofire.request(MBRouter.login(email: email, password: password, idfa: "asdasdasdas"))
//
//            .responseJSON { (response) in
//       debugPrint(response)
//
//                switch response.result {
//                case .success(let json):
//                    print("\(json)")
//                    completion(nil)
//                case .failure(let error ):
//                    print("\(error.localizedDescription)")
//                    completion(nil)
//                }
//
//
//
//
//
//        }
//
//    }
//
    func login(email:String, password:String, completion:@escaping (UserInformation?) -> Void) {
 
        
    }
    
//    func logout(){
//        
//    }
//func getInvestorProductsForThisWeek(completion:@escaping (Result<InvestorProducts>)->Void) {
//        let request1 =  MBRouter.thisWeek
//
//
//
//
//    }
//    func incrementMoneyboxBy(Amout:Double)-> Moneybox {
//
//    }
//
    
    
    class func sharedInstance() -> MBClient{
        struct Singleton {
            static var sharedInstance = MBClient()
        }
        return Singleton.sharedInstance
    }
}

