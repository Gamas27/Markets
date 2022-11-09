//
//  TickerListRowData.swift
//  MarketsApp
//
//  Created by João Gameiro on 31/10/2022.
//

import Foundation

typealias PriceChange = (price: String, change: String)

struct TickerListRowData {
    enum RowType {
        case main
        case search(isSaved: Bool, onButtonTapped: () -> ())
    }
    
    let symbol: String
    let name: String?
    let price: PriceChange?
    let type: RowType
}
