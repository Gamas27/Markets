//
//  AppViewModel.swift
//  MarketsApp
//
//  Created by João Gameiro on 31/10/2022.
//

import Foundation
import SwiftUI
import StocksAPI

@MainActor
class AppViewModel: ObservableObject {
    
    @Published var state: FetchState<[Ticker]> = .initial
    
    var tickers: [Ticker] {
        get { return state.value ?? [] }
        set { self.tickers = newValue }
    }
    
    @Published var selectedTicker: Ticker?
    
    var error: Error? { state.error }
    
    var emptyListText: String {
        "No symbols found"
    }
    
    var titleText = "Stocks"
    @Published var subtitleText: String
    
    let query: String = "AAPL,MSFT,GOOG,TSLA,NVDA,AMD"
    
    private let subtitleDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "d MMM"
        return df
    }()
    
    private let stocksAPI: StocksAPI
    
    init(stocksAPI: StocksAPI = StocksAPI()) {
        self.subtitleText = subtitleDateFormatter.string(from: Date())
        self.stocksAPI = stocksAPI
    }
    
    func searchTickers() async {
        state = .fetching
        do {
            let tickers = try await stocksAPI.searchTickers(query: query, isEquityTypeOnly: true)
            if tickers.isEmpty {
                state = .empty
            } else {
                state = .success(tickers)
            }
        } catch {
            print(error.localizedDescription)
            state = .failure(error)
        }
    }
}
