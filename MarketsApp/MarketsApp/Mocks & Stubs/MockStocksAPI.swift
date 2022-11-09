//
//  MockStocksAPI.swift
//  MarketsApp
//
//  Created by João Gameiro on 01/11/2022.
//

import Foundation
import StocksAPI

#if DEBUG
struct MockStocksAPI: StocksAPIRepository {
    
    var stubbedSearchTickersCallback: (() async throws -> [Ticker])!
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker] {
        try await stubbedSearchTickersCallback()
    }
    
    var stubbedFetchQuotesCallback: (() async throws -> [Quote])!
    func fetchQuotes(symbols: String) async throws -> [Quote] {
        try await stubbedFetchQuotesCallback()
    }
}
#endif
