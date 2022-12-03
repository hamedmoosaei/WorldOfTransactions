//
//  TransactionListItemModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation

struct TransactionListItemModel {
    var bookingDate: String
    var partnerDisplayName: String
    var transactionDetailDescription: String?
    var valueAmount: Int
    var valueCurrency: String?
    var category: Int
}
