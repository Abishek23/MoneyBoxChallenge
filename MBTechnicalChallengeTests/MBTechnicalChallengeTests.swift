//
//  MBTechnicalChallengeTests.swift
//  MBTechnicalChallengeTests
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 Abishek Gokal. All rights reserved.
//

import XCTest
@testable import MBTechnicalChallenge

class MBTechnicalChallengeTests: XCTestCase {
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        MBClient.sharedInstance().loginRequest(email: MBConstants.APIParamterValue.email, password: MBConstants.APIParamterValue.password) { (UserInformation, Error) -> (Void) in
            if let error = Error {
                
                
            } else if UserInformation != nil {
                
            MBClient.sharedInstance().userInformation = UserInformation!
            }
            
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidCallToLoginAPI() {
        let promise = expectation(description: "Succes")
        
        MBClient.sharedInstance().loginRequest(email: MBConstants.APIParamterValue.email, password: MBConstants.APIParamterValue.password) { (UserInformation, Error) -> (Void) in
            if let error = Error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if UserInformation != nil {
                promise.fulfill()
            
            }
            
        }
        
        waitForExpectations(timeout: 30, handler: nil)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testLoginAPIInvalidCreds() {
        let promise = expectation(description: "Success")
        
        MBClient.sharedInstance().loginRequest(email: MBConstants.APIParamterValue.email, password: MBConstants.APIParamterValue.password) { (UserInformation, Error) -> (Void) in
            if let error = Error {
          
                 promise.fulfill()
            } else if UserInformation != nil {
               
                XCTFail("Failed")
            }
            
        }
        
        waitForExpectations(timeout: 30, handler: nil)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

    func testInvestorProductAPI(){
        let promise = expectation(description: "Success")
        
        MBClient.sharedInstance().investorProductsRequest { (InvestorProducts, Error) -> (Void) in
            if let error = Error {
                XCTFail("Error:\(error.localizedDescription)")
            } else if InvestorProducts != nil {
             
                promise.fulfill()
            }
            
        }
     
        waitForExpectations(timeout: 30, handler: nil)
    }
    
  
}
