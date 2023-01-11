//
//  String+DateExtension .swift
//  WorldOfTransactions
//
//  Created by Hamed Moosaei on 11/27/22.
//

import Foundation

extension String {
    var date: Date {
        let ISODateFormater = ISO8601DateFormatter()
        
        return ISODateFormater.date(from: self) ?? Date()
    }
}

extension Date {
    var localizedDateFromISO: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        return dateFormatter.string(from: self)
    }
}
