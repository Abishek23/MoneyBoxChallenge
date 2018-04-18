//
//  File.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
struct ProductDetails: Codable {
    let name, type: String
    let annualLimit, depositLimit: Int
    let friendlyName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case type = "Type"
        case annualLimit = "AnnualLimit"
        case depositLimit = "DepositLimit"
        case friendlyName = "FriendlyName"
    }
}
extension ProductDetails {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ProductDetails.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
