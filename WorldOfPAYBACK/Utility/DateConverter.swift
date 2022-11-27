//
//  DateConverter.swift
//  WorldOfPAYBACK
//
//  Created by Hamed Moosaei on 11/27/22.
//

import Foundation

struct DateConverter {
    
    // Convert from ISO 8601 to proper format
    static func dateConverter(str: String) -> String {
        let ISODateFormater = ISO8601DateFormatter()
        let date = ISODateFormater.date(from: str)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        return dateFormatter.string(from: date ?? Date())
    }
}
