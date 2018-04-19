//
//  MBClient.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import Whisper
import SVProgressHUD
import AdSupport
class MBClient : NSObject {
    // MARK: Properties
    
    //authentication state
    var userInformation:UserInformation? = nil
    var investorProducts:InvestorProducts? = nil

//    }
    
    
    func setupRequest(serviceURL:URL,method:HTTPMethod,authenticated:Bool,paramaters:[String:Any])->URLRequest?{
        
        //initialize new request
        var request = URLRequest(url: serviceURL)
        
        //configure request
        request.httpMethod = method.rawValue
        request.setValue(AppID.ID.rawValue, forHTTPHeaderField: HTTPHeaderField.appID.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(ApiVersion.three.rawValue, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)
        request.setValue(AppVersion.four.rawValue, forHTTPHeaderField: HTTPHeaderField.appVersion.rawValue)
        request.timeoutInterval = TimeInterval(60)
        
        //parse paramters as JSON, set request body.
        guard let httpBody = try? JSONSerialization.data(withJSONObject: paramaters, options: []) else {return nil}
        request.httpBody = httpBody
        
        
        //if request requires authentication add auth token
        if authenticated {
            guard let token = userInformation?.session.bearerToken else {return nil}
            let authToken = "Bearer \(token)"
            request.setValue(authToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        return request
    }
    
    func loginRequest(email:String,password:String, completion:@escaping(UserInformation?, Error?)->(Void)) {
        //  let url = NSURL(string: MBConstants.TestServer+"/users/login")
             SVProgressHUD.show()
        let serviceUrl = MBConstants.APIEndpoints.login
        let parameterDictionary = [MBConstants.APIParameterKey.email:email, MBConstants.APIParameterKey.password: password, MBConstants.APIParameterKey.idfa: MBConstants.APIParamterValue.idfa]
        
        guard let loginRequest = setupRequest(serviceURL: serviceUrl, method:.post, authenticated: false, paramaters: parameterDictionary) else {return }
        let session = URLSession.shared
        session.dataTask(with: loginRequest) { (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil,error!)
                }
                
                return
                }
            
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let userInfo = try JSONDecoder().decode(UserInformation.self, from: data)
                    
                    self.userInformation = userInfo
                    
                    print("UserInformationObject:\(String(describing: userInfo))")
                
                    DispatchQueue.main.async {
                        completion(userInfo,nil)
                    }
                    
                    
                    
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                          completion(nil, error)
                    }
                  
                }
            }
            }.resume()
        
    }
    
    func investorProductsRequest(completion:@escaping(InvestorProducts?, Error?)->(Void)) {
        SVProgressHUD.show()
    let serviceUrl = MBConstants.APIEndpoints.thisweek
   
    guard let investorProductRequest = setupRequest(serviceURL: serviceUrl, method: .get, authenticated: true, paramaters: [:]) else {return}
        let session = URLSession.shared
        
        //execute request
        session.dataTask(with: investorProductRequest) { (data, response, error) in
            //handle error
            guard error == nil else {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                      completion(nil,error)
                }
  
                return
            }
            
            
          //JSON parsing
            if let data = data {
                do {
                    self.investorProducts = try JSONDecoder().decode(InvestorProducts.self, from: data)
                    print("InvestorProducts:\(self.investorProducts)")
                    DispatchQueue.main.async {
                         completion(self.investorProducts,nil)
                    }
                   
                } catch {
                    
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                    
                }
            }
            }.resume()
        
    }
    
    
    

    func oneOffPaymentRequest(amount : Int, inverstorProductId:Int, completion:@escaping(Moneybox?,Error?)->(Void)) {
        SVProgressHUD.show()
        let serviceUrl = MBConstants.APIEndpoints.oneoffpayment
        
        let parameterDictionary = [MBConstants.APIParameterKey.amount:amount, MBConstants.APIParameterKey.inverstorProductID: inverstorProductId]
        
        guard let paymentRequest = setupRequest(serviceURL: serviceUrl, method: .post, authenticated: true, paramaters: parameterDictionary) else {return}
        
        
        let session = URLSession.shared
        
        //excecute request
        session.dataTask(with: paymentRequest) { (data, response, error) in
            
            
            //handle error
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil,error)
                return
            }
            // parse JSON
            if let data = data {
                do {
                    let mb = try JSONDecoder().decode(Moneybox.self, from: data)
                    print("Moneybox :\(mb)")
                    DispatchQueue.main.async {
                            completion(mb,nil)
                    }
                  
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                }
            }
            }.resume()
        
    }
    
    
    
    func logout(completion:@escaping(Bool, Error?)->(Void)) {
        SVProgressHUD.show()
        let serviceUrl = MBConstants.APIEndpoints.logout
        guard let logoutRequest = setupRequest(serviceURL: serviceUrl, method: .post, authenticated: true, paramaters: [:]) else {return}
        
    
        let session = URLSession.shared
        //execute request
        session.dataTask(with: logoutRequest) { (data, response, error) in
            
            //handle error
            guard error == nil else {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                     completion(false,error)
                }
 
                return
            }
            // else logout success
            DispatchQueue.main.async {
                  completion(true, nil)
            }
            

            }.resume()
        
    }
    

    
    // Singleton
    class func sharedInstance() -> MBClient{
        struct Singleton {
            static var sharedInstance = MBClient()
        }
        return Singleton.sharedInstance
    }
}

