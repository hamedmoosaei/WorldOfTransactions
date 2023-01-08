//
//  TransactionRemoteDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 12/25/22.
//

import Foundation
import RxSwift

protocol TransactionRemoteDataSource {
    func provideTransactionData() -> Observable<TransactionDecodableModel>
}

struct TransactionURLSessionDataSource: TransactionRemoteDataSource {
    
    private let networkService: NetworkServer
    
    init(networkService: NetworkServer) {
        self.networkService = networkService
    }
    
    func provideTransactionData() -> Observable<TransactionDecodableModel> {
        
        let response: Observable<TransactionDecodableModel> = networkService.request()
        
        return response
    }
}
