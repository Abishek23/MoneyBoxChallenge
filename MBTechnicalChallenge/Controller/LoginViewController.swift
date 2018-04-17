//
//  ViewController.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import UIKit
import Alamofire
import AdSupport
class ViewController: UIViewController {
  var userInformation:UserInformation? = nil
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBAction func login(_ sender: UIButton) {
      
//        guard let email = emailTextField.text, let password = passwordTextField.text else {
//            return
//
//        }
//
        loginRequest()
        
//        MBClient.sharedInstance().login(email: "test+env12@moneyboxapp.com", password: "Money$$box@107") { (userInfo ) in
//
//            if userInfo != nil {
//                MBClient.sharedInstance().userInformation = userInfo
//            } else {
//                print ("Log in failed try again")
//            }
//
//        }
    }
    
    @IBAction func getProducts(_ sender: Any) {
        investorProductsRequest()
    }
    func loginRequest() {
      //  let url = NSURL(string: MBConstants.TestServer+"/users/login")
        guard  let serviceUrl = URL(string: "https://api-test00.moneyboxapp.com/users/login") else {return}
        let parameterDictionary = ["Email":"test+env12@moneyboxapp.com", "Password": "Money$$box@107", "Idfa": ASIdentifierManager.shared().advertisingIdentifier.uuidString]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(AppID.ID.rawValue, forHTTPHeaderField: HTTPHeaderField.appID.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(ApiVersion.three.rawValue, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)
        request.setValue(AppVersion.four.rawValue, forHTTPHeaderField: HTTPHeaderField.appVersion.rawValue)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    self.userInformation = try JSONDecoder().decode(UserInformation.self, from: data)
                    print("UserInformationObject:\(self.userInformation)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    func investorProductsRequest() {
        //  let url = NSURL(string: MBConstants.TestServer+"/users/login")
        
        
        guard let token = userInformation?.session.bearerToken else {return}
        let authToken = "Bearer \(token)"
        guard  let serviceUrl = URL(string: "https://api-test00.moneyboxapp.com/investorproduct/thisweek") else {return}
        let parameterDictionary = ["Email":"test+env12@moneyboxapp.com", "Password": "Money$$box@107", "Idfa": ASIdentifierManager.shared().advertisingIdentifier.uuidString]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(AppID.ID.rawValue, forHTTPHeaderField: HTTPHeaderField.appID.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(ApiVersion.three.rawValue, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)
        request.setValue(AppVersion.four.rawValue, forHTTPHeaderField: HTTPHeaderField.appVersion.rawValue)
        request.setValue(authToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let investorProducts = try JSONDecoder().decode(InvestorProducts.self, from: data)
                    print("InvestorProducts:\(investorProducts)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
        
    }
    
    //isa ID = 3289 gia = 3292
    func oneOffPaymentRequest(amount : Int) {
        //  let url = NSURL(string: MBConstants.TestServer+"/users/login")
        guard  let serviceUrl = URL(string: "https://api-test00.moneyboxapp.com/oneoffpayments") else {return}
        
        guard let token = userInformation?.session.bearerToken else {return}
        let authToken = "Bearer \(token)"
        let parameterDictionary = ["Amount":amount, "InvestorProductId": 3289]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(AppID.ID.rawValue, forHTTPHeaderField: HTTPHeaderField.appID.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(ApiVersion.three.rawValue, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)
        request.setValue(AppVersion.four.rawValue, forHTTPHeaderField: HTTPHeaderField.appVersion.rawValue)
        request.setValue(authToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let mb = try JSONDecoder().decode(Moneybox.self, from: data)
                    print("Moneybox :\(mb)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
        
    }
    
    
    
    func logout() {
        //  let url = NSURL(string: MBConstants.TestServer+"/users/login")
        guard  let serviceUrl = URL(string: "https://api-test00.moneyboxapp.com/users/logout") else {return}
        
        guard let token = userInformation?.session.bearerToken else {return}
        let authToken = "Bearer \(token)"
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(AppID.ID.rawValue, forHTTPHeaderField: HTTPHeaderField.appID.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.setValue(ApiVersion.three.rawValue, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)
        request.setValue(AppVersion.four.rawValue, forHTTPHeaderField: HTTPHeaderField.appVersion.rawValue)
        request.setValue(authToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: [], options: []) else {return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let mb = try JSONDecoder().decode(Moneybox.self, from: data)
                    print("Moneybox :\(mb)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
        
    }
    
    
    
    @IBAction func moneyBoxAction(_ sender: UIButton) {
        oneOffPaymentRequest(amount: 10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

