//
//  TickerQuoteViewModel.swift
//  MarketsApp
//
//  Created by João Gameiro on 01/11/2022.
//

import Foundation
import SwiftUI
import StocksAPI

@MainActor
class TickerQuoteViewModel: ObservableObject {
    
    @Published var state = FetchState<Quote>.initial
    var quote: Quote? { state.value }
    var error: Error? { state.error }
    
    let ticker: Ticker
    let stocksAPIRepo: StocksAPIRepository
    
    init(ticker: Ticker, stocksAPIRepo: StocksAPIRepository = StocksAPI()) {
        self.ticker = ticker
        self.stocksAPIRepo = stocksAPIRepo
    }
    
    func fetchQuote() async {
        state = .fetching
        
        do {
            let response = try await stocksAPIRepo.fetchQuotes(symbols: ticker.symbol)
            if let quote = response.first {
                state = .success(quote)
            } else {
                state = .empty
            }
        } catch {
            print(error.localizedDescription)
            state = .failure(error)
        }
    }
    
}
