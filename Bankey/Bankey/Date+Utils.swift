//
//  Date+Utils.swift
//  Bankey
//
//  Created by simonecaria on 12/02/25.
//

import Foundation

extension Date {
    static var bankeyFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "IT")
        return formatter
    }
    
    var monthDayYearString : String {
        let dateFormatter = Date.bankeyFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
