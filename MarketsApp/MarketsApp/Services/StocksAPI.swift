//
//  StocksAPI.swift
//  MarketsApp
//
//  Created by João Gameiro on 01/11/2022.
//

import Foundation
import StocksAPI

protocol StocksAPIRepository {
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker]
    func fetchQuotes(symbols: String) async throws -> [Quote]
}

extension StocksAPI: StocksAPIRepository {}
