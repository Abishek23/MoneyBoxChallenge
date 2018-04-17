//
//  MBConfiguration.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
import Alamofire
protocol MBConfiguration:URLRequestConvertible{
    var method: HTTPMethod { get }
    var path:String { get }
    var parameters: Parameters? { get }
}
