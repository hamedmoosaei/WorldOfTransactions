//
//  TransactionListModel.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/23/22.
//

import Foundation

struct TransactionListModel {
    var bookingDate: Date
    var partnerDisplayName: String
    var transactionDetailDescription: Description?
    var valueAmount: Int
    var valueCurrency: Currency?
}
