//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift

class TransactionListViewModel {
    var model: [TransactionListItemModel]?
    var itemsToShow: [TransactionListItemModel] {
        return model ?? []
    }
    var disposeBag = DisposeBag()
    
    func fetchTransactions() {
        let request: MockRequest<TransactionDecodableModel> = MockRequest(endPoint: .transactionList)
        
        request.perform()
            .subscribe(onNext: { transactions in
                self.model = transactions.items.map({ transaction in
                    return TransactionListItemModel(
                        bookingDate: DateConverter.dateConverter(str: transaction.transactionDetail.bookingDate),
                        partnerDisplayName: transaction.partnerDisplayName,
                        transactionDetailDescription: transaction.transactionDetail.transactionDetailDescription?.rawValue,
                        valueAmount: transaction.transactionDetail.value.amount,
                        valueCurrency: transaction.transactionDetail.value.currency.rawValue)
                })
            }).disposed(by: disposeBag)
    }
    
    
    
}

