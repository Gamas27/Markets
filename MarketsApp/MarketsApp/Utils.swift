//
//  Utils.swift
//  MarketsApp
//
//  Created by João Gameiro on 31/10/2022.
//

import Foundation

struct Utils {
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    static func format(value: Double?) -> String? {
        guard let value,
              let text = numberFormatter.string(from: NSNumber(value: value))
        else { return nil }
        return text
    }
}
