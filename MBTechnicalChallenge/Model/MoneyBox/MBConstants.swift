//
//  MBConstants.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import AdSupport
struct MBConstants {
    

    struct TestServer {
        static let baseURL = URL(string:  "https://api-test00.moneyboxapp.com")
       
    }

    
    struct APIEndpoints {
    static let login = TestServer.baseURL?.appendingPathComponent("/users/login")
    static let logout = TestServer.baseURL?.appendingPathComponent("/users/logout")
    static let thisweek = TestServer.baseURL?.appendingPathComponent("/investorproduct/thisweek")
    static let oneoffpayment = TestServer.baseURL?.appendingPathComponent("/oneoffpayments")
    }
    
    struct APIParameterKey {
        static let password = "Password"
        static let email = "Email"
        static let idfa = "Idfa"
        static let amount = "Amount"
        static let inverstorProductID = "InvestorProductId"
        
        
    }
    
    struct APIParamterValue {
        static let password = "Money$$box@107"
        static let email = "test+env12@moneyboxapp.com"
        static let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        static let fixedDeposit = 10
        
        
    }
}

enum HTTPHeaderField:String {
    case appID = "AppId"
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEnconding = "Accept-Encoding"
    case appVersion = "appVersion"
    case apiVersion = "apiVersion"
}

enum HTTPMethod:String{
    case post = "POST"
    case get = "GET"
}

enum ContentType:String {
    case json = "application/json"
}

enum AppVersion : String {
    case four = "4.0.0"
}
enum ApiVersion : String {
    case three = "3.0.0"
}
enum AppID :String {
    case ID = "8cb2237d0679ca88db6464"
}
