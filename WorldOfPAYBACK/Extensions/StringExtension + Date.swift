//
//  StringExtension + Date.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/27/22.
//

import Foundation

extension String {
    
    var localizedDateFromISO: String {
        let ISODateFormater = ISO8601DateFormatter()
        let date = ISODateFormater.date(from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        return dateFormatter.string(from: date ?? Date())
    }
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
