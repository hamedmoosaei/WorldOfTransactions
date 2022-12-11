//
//  TransactionListItemModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift

struct TransactionListItemModel {
    var bookingDate: String
    var partnerDisplayName: String
    var transactionDetailDescription: String?
    var valueAmount: Int
    var valueCurrency: String?
    var category: Int
}

extension TransactionListItemModel {
    init(transaction: Transaction) {
        bookingDate = transaction.transactionDetail.bookingDate.localizedDateFromISO
        partnerDisplayName = transaction.partnerDisplayName
        transactionDetailDescription = transaction.transactionDetail.transactionDetailDescription?.rawValue
        valueAmount = transaction.transactionDetail.value.amount
        valueCurrency = transaction.transactionDetail.value.currency.rawValue
        category = transaction.category
    }
}

extension TransactionListItemModel {
    var date: Observable<String> {
        Observable.just(bookingDate)
    }
    
    var displayName: Observable<String> {
        Observable.just(partnerDisplayName)
    }
    
    var description: Observable<String?> {
        Observable.just(transactionDetailDescription)
    }
    
    var valueAndCurrency: Observable<String> {
        Observable.just(String(describing: valueAmount) + " " + (valueCurrency ?? ""))
    }
}

extension TransactionListItemModel {
    static func >(lhs:TransactionListItemModel, rhs: TransactionListItemModel) -> Bool {
        return lhs.bookingDate.date > rhs.bookingDate.date
    }
}
