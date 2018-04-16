//
//  User.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation

struct User: Codable {
    let userID: String
    let hasVerifiedEmail, isPinSet: Bool
    let registrationStatus, dateCreated, moneyboxRegistrationStatus, email: String
    let firstName, lastName: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "UserId"
        case hasVerifiedEmail = "HasVerifiedEmail"
        case isPinSet = "IsPinSet"
        case registrationStatus = "RegistrationStatus"
        case dateCreated = "DateCreated"
        case moneyboxRegistrationStatus = "MoneyboxRegistrationStatus"
        case email = "Email"
        case firstName = "FirstName"
        case lastName = "LastName"
    }
}


extension User {
    init(data: Data) throws {
        self = try JSONDecoder().decode(User.self, from: data)
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
