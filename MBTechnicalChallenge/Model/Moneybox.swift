//
//  Moneybox.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 Abishek Gokal. All rights reserved.
//

import Foundation
struct Moneybox: Codable {
    let moneybox: Int
    
    enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
    }
}
extension Moneybox {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Moneybox.self, from: data)
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
