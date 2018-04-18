//
//  ViewController.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import UIKit
import SVProgressHUD
import AdSupport
import Whisper
class LoginViewController: UIViewController {
 
  
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var loginOutlet: UIButton!
    

    func enableInputs(){
        self.passwordTextField.isUserInteractionEnabled = true
        self.emailTextField.isUserInteractionEnabled = true
        self.loginOutlet.isUserInteractionEnabled = true
    }
    func disableInputs(){
        self.passwordTextField.isUserInteractionEnabled = false
        self.emailTextField.isUserInteractionEnabled = false
        self.loginOutlet.isUserInteractionEnabled = false
    }
    @IBAction func login(_ sender: UIButton) {
      
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return

        }
        

        MBClient.sharedInstance().loginRequest(email: email , password: password) { (userInfo,error)  -> (Void) in
      
            DispatchQueue.main.async {
                SVProgressHUD.show()
                self.disableInputs()
                
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    let message = Message(title: "Error:\(String(describing: error?.localizedDescription))", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
                   self.enableInputs()
                }
            }
            if let userInfo = userInfo {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                             self.performSegue(withIdentifier: "productsSegue", sender: sender)
                  self.enableInputs()
                }
       
                print(userInfo)
            } else {
                print("error occured")
                
                DispatchQueue.main.async {
                    let message = Message(title: "Login failed please try again", backgroundColor: .red)
                    SVProgressHUD.dismiss()
                    // Show and hide a message after delay
                    Whisper.show(whisper: message, to: self.navigationController!, action: .show)
                    self.enableInputs()
                }
                
            }
            
        }

    }
    
//    @IBAction func getProducts(_ sender: Any) {
//        MBClient.sharedInstance().investorProductsRequest { (investorProducts) -> (Void) in
//            if let investorProd = investorProducts {
//                print(investorProd)
//            } else {
//                print("error")
//            }
//        }
//    }
//
//
    

    
    
//    @IBAction func moneyBoxAction(_ sender: UIButton) {
//        //oneOffPaymentRequest(amount: 10, inverstorProductId: 3289)
//        MBClient.sharedInstance().oneOffPaymentRequest(amount: 10, inverstorProductId: 3289) { (moneyBox) -> (Void) in
//            if let mb = moneyBox {
//                print(mb)
//            } else {
//                print("error")
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

