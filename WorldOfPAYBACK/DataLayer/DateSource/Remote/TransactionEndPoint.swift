//
//  TransactionEndPoint.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 12/25/22.
//

import Foundation

enum TransactionEndPoint: EndPoint {
            
    case transactionList
    case transactionListTest
    
    var baseUrl: URL {
        switch self {
        case .transactionList:
            return URL(string: "https://api.payback.com")!
        case .transactionListTest:
            return URL(string: "https://api-test.payback.com")!
        }
    }
            
    var path: String {
        return "/transactions"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
