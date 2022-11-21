//
//  TransactionModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/21/22.
//

import Foundation

// MARK: - Welcome
struct TransactionList: Codable {
    let items: [Transaction]
}

// MARK: - Item
struct Transaction: Codable {
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail
}

// MARK: - Alias
struct Alias: Codable {
    let reference: String
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable {
    let transactionDetailDescription: Description?
    let bookingDate: Date
    let value: Value

    enum CodingKeys: String, CodingKey {
        case transactionDetailDescription = "description"
        case bookingDate, value
    }
}

enum Description: String, Codable {
    case punkteSammeln = "Punkte sammeln"
}

// MARK: - Value
struct Value: Codable {
    let amount: Int
    let currency: Currency
}

enum Currency: String, Codable {
    case pbp = "PBP"
}
