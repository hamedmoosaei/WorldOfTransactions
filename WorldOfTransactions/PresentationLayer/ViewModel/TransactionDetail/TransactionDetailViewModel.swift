//
//  TransactionDetailViewModel.swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 12/4/22.
//

import Foundation

protocol TransactionDetailViewModelProtocol {
    var transactionDetailModel: TransactionDetailModel { get }
}

class TransactionDetailViewModel: TransactionDetailViewModelProtocol {
    public var transactionDetailModel: TransactionDetailModel
    
    init(transactionDetailModel: TransactionDetailModel) {
        self.transactionDetailModel = transactionDetailModel
    }
    
}
