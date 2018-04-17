//
//  MBRouter.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import Alamofire

enum MBRouter:MBConfiguration {

    
    case login(email:String,password:String,idfa:String)
    case logout
    case thisWeek
    case oneOffPayment
    
    
    // Http Method
    internal var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .post
        case .thisWeek:
            return .get
        case .oneOffPayment:
            return .post
        
        }
    }
    
    // Path
    internal var path : String {
        switch self {
        case .login:
            return "/users/login"
        case .logout:
            return "users/logout"
        case .thisWeek:
            return "investorproduct/thisweek"
        case .oneOffPayment:
            return "/oneoffpayments"
   
    }
    }
    
    // Params
    internal var parameters: Parameters? {
            switch self {
            case .login(let email, let password, let idfa):
                return [MBConstants.APIParameterKey.email:email, MBConstants.APIParameterKey.password:password, MBConstants.APIParameterKey.idfa:idfa]
            case .logout:
                return nil
            case .thisWeek:
                return nil
                
            case .oneOffPayment:
                return nil
            }
        
        }
    // confrom to URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try MBConstants
            .TestServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers

        urlRequest.setValue(AppID.ID.rawValue, forHTTPHeaderField: HTTPHeaderField.appID.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ApiVersion.three.rawValue, forHTTPHeaderField: HTTPHeaderField.apiVersion.rawValue)
        urlRequest.setValue(AppVersion.four.rawValue, forHTTPHeaderField: HTTPHeaderField.appVersion.rawValue)
        
      //  urlRequest.setValue(, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
    return urlRequest
    }
    


}
