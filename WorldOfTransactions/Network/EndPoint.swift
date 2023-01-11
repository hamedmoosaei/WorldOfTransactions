//
//  EndPoint.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/21/22.
//

import Foundation

protocol EndPoint {

    var baseUrl: URL { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    /*
        We can define other varibales
        like Header or Validation or
        Task. Task can be used for
        adding parameters to request.
     */
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
