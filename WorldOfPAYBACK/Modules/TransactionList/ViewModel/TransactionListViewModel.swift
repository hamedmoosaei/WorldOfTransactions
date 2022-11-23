//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift

class TransactionListViewModel {
    var model: [TransactionListModel]?
    var itemsToShow: [TransactionListModel]?
    var disposeBag = DisposeBag()
    
    func fetchTransactions() {
        let request: Request<TransactionDecodableModel> = Request(endPoint: .transactionList)
        
        request.perform()
            .subscribe(onNext: { transactions in
                self.model = transactions.items.map({ transaction in
                    return TransactionListModel(
                        bookingDate: transaction.transactionDetail.bookingDate,
                        partnerDisplayName: transaction.partnerDisplayName,
                        transactionDetailDescription: transaction.transactionDetail.transactionDetailDescription,
                        valueAmount: transaction.transactionDetail.value.amount,
                        valueCurrency: transaction.transactionDetail.value.currency)
                })
            }).disposed(by: disposeBag)
    }
    
       
    
}

