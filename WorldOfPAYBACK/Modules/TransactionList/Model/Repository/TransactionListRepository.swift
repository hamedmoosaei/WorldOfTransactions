//
//  TransactionListRepository.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 12/21/22.
//

import Foundation
import RxSwift

protocol TransactionListRepository {
    func getTransactionList() -> Observable<[TransactionBusinessModel]>
    func getFilteredTransactionByCategory(selectedCategories: [Int]) -> Observable<[TransactionBusinessModel]>
    func getCategories() -> [Int]
}

class TransactionListRepositoryImpl: TransactionListRepository {
    
    private let remoteDataSource: TransactionRemoteDataSource
    private let localDataSource: TransactionLocalDataSource
    
    private var transactionList: [TransactionBusinessModel] = []
    private var disposeBag = DisposeBag()
        
    init(remoteDataSource: TransactionRemoteDataSource, localDataSource: TransactionLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getTransactionList() -> Observable<[TransactionBusinessModel]> {
        let transactions = localDataSource.provideTransactionData()
            .map(mapDecodableToBusiness(model:))
            .flatMap({
                Observable.from(optional: $0.sorted(by: >))
            })
        
        transactions.subscribe { transactions in
            self.transactionList = transactions
        }.disposed(by: disposeBag)
        
        return transactions
    }
    
    func getFilteredTransactionByCategory(selectedCategories: [Int]) -> Observable<[TransactionBusinessModel]> {
        return Observable.just(transactionList.filter({ selectedCategories.contains($0.category) }))
    }
    
    func getCategories() -> [Int] {
        let categoryModel = Array(Set(transactionList.map({ $0.category }))).sorted(by: <)
        return categoryModel
    }

    private func mapDecodableToBusiness(model: TransactionDecodableModel) -> [TransactionBusinessModel] {
        return model.items.map(TransactionBusinessModel.init(model: ))
    }
}
