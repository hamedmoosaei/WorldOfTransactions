//
//  TransactionListItemModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 12/28/22.
//

import Foundation

struct TransactionListItemModel {
    var date: String
    var displayName: String
    var description: String?
    var valueAndCurrency: String
}

extension TransactionListItemModel {
    init(model: TransactionBusinessModel) {
        date = model.bookingDate.localizedDateFromISO
        displayName = model.partnerDisplayName
        description = model.transactionDetailDescription
        valueAndCurrency = String(describing: model.valueAmount) + " " + (model.valueCurrency ?? "")
    }
}
