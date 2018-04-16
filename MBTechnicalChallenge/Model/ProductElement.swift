//
//  ProductElement.swift
//  MBTechnicalChallenge
//
//  Created by Abishek Gokal on 16/04/2018.
//  Copyright © 2018 abishek. All rights reserved.
//

import Foundation
struct ProductElement: Codable {
    let investorProductID: Int
    let investorProductType: String
    let productID, moneybox, previousMoneybox, subscriptionAmount: Int
    let planValue, sytd, transferInSytd, maximumDeposit: Int
    let totalContributions, totalReturnValue, totalReturnPercentage, cashInTransit: Int
    let residualCash, totalFees, totalReturnValueGross, pendingWithdrawal: Int
    let isPendingRebalance: Bool
    let pendingDeposit: Int
    let product: ProductDetails
    let dateModified: String
    let valuations: [JSONAny]
    let isSelected, isFavourite: Bool
    let maximumWithdrawal: Int?
    
    enum CodingKeys: String, CodingKey {
        case investorProductID = "InvestorProductId"
        case investorProductType = "InvestorProductType"
        case productID = "ProductId"
        case moneybox = "Moneybox"
        case previousMoneybox = "PreviousMoneybox"
        case subscriptionAmount = "SubscriptionAmount"
        case planValue = "PlanValue"
        case sytd = "Sytd"
        case transferInSytd = "TransferInSytd"
        case maximumDeposit = "MaximumDeposit"
        case totalContributions = "TotalContributions"
        case totalReturnValue = "TotalReturnValue"
        case totalReturnPercentage = "TotalReturnPercentage"
        case cashInTransit = "CashInTransit"
        case residualCash = "ResidualCash"
        case totalFees = "TotalFees"
        case totalReturnValueGross = "TotalReturnValueGross"
        case pendingWithdrawal = "PendingWithdrawal"
        case isPendingRebalance = "IsPendingRebalance"
        case pendingDeposit = "PendingDeposit"
        case product = "Product"
        case dateModified = "DateModified"
        case valuations = "Valuations"
        case isSelected = "IsSelected"
        case isFavourite = "IsFavourite"
        case maximumWithdrawal = "MaximumWithdrawal"
    }
}
extension ProductElement {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ProductElement.self, from: data)
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
