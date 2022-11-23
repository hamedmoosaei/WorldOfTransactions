//
//  EndPoint.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/21/22.
//

import Foundation

enum EndPoint {
    case transactionList
    
//    var modelType: Decodable.Type {
//        switch self {
//        case .transactionList:
//            return TransactionDecodableModel.self
//        }
//    }
    
    var url: URL {
        switch self {
        case .transactionList:
            return URL(string: "https://api.payback.com/transactions")!
        }
    }
    var testUrl: URL {
        switch self {
        case .transactionList:
            return URL(string: "https://api-test.payback.com/transactions")!
        }
    }
    var mockUrl: URL {
        switch self {
        case .transactionList:
            let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json")!
            return URL(fileURLWithPath: path)
        }
    }
}
