//
//  TransactionLocalDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 12/25/22.
//

import Foundation
import RxSwift

protocol TransactionLocalDataSource {
    func provideTransactionData() -> Observable<TransactionDecodableModel>
}

struct TransactionJsonReaderDataSource: TransactionLocalDataSource {
    
    func provideTransactionData() -> Observable<TransactionDecodableModel> {
        let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json")!
        let pathUrl = URL(fileURLWithPath: path)
        
        return Observable.just(pathUrl)
            .flatMap { url -> Observable<Data> in
                let data = try Data(contentsOf: url)
                return Observable.just(data)
            }.map { data in
                return try JSONDecoder().decode(TransactionDecodableModel.self, from: data)
            }
    }
}
