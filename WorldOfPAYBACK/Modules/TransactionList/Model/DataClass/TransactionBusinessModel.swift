//
//  TransactionListItemModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation
import RxSwift

struct TransactionBusinessModel {
    var bookingDate: Date
    var partnerDisplayName: String
    var transactionDetailDescription: String?
    var valueAmount: Int
    var valueCurrency: String?
    var category: Int
}

extension TransactionBusinessModel {
    init(model: TransactionDecodable) {
        bookingDate = model.transactionDetail.bookingDate.date
        partnerDisplayName = model.partnerDisplayName
        transactionDetailDescription = model.transactionDetail.transactionDetailDescription?.rawValue
        valueAmount = model.transactionDetail.value.amount
        valueCurrency = model.transactionDetail.value.currency.rawValue
        category = model.category
    }
}

extension TransactionBusinessModel {
    static func >(lhs:TransactionBusinessModel, rhs: TransactionBusinessModel) -> Bool {
        return lhs.bookingDate > rhs.bookingDate
    }
}
