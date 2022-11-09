//
//  ContentView.swift
//  MarketsApp
//
//  Created by João Gameiro on 31/10/2022.
//

import SwiftUI
import StocksAPI

struct StockListView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    
    var body: some View {
        tickerListView
            .listStyle(.plain)
            .toolbar {
                titleToolBar
            }
            .overlay { listStateOverlay }
            .sheet(item: $appVM.selectedTicker) {
                StockTickerView(quoteVM: .init(ticker: $0, stocksAPIRepo: quotesVM.stocksAPI))
                    .presentationDetents([.height(560)])
            }
            .task(id: "Tickers") { await appVM.searchTickers() }
            .task(id: appVM.tickers) { await quotesVM.fetchQuotes(tickers: appVM.tickers) }
            
    }
    
    @ViewBuilder
    private var listStateOverlay: some View {
        switch appVM.state {
        case .failure(let error):
            ErrorStateView(error: error.localizedDescription) {
                Task { await appVM.searchTickers() }
            }
        case .empty:
            EmptyStateView(text: appVM.emptyListText)
        case .fetching:
            LoadingStateView()
        default: EmptyView()
        }
    }
    
    private var tickerListView: some View {
        List {
            ForEach(appVM.tickers) { ticker in
                TickerListRowView(
                    data: .init(
                        symbol: ticker.symbol,
                        name: ticker.shortname,
                        price: quotesVM.priceForTicker(ticker),
                        type: .main))
                .contentShape(Rectangle())
                .onTapGesture {
                    appVM.selectedTicker = ticker
                }
            }
        }
    }
    
    private var titleToolBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            VStack(alignment: .leading, spacing: -4) {
                Text(appVM.titleText)
                Text(appVM.subtitleText).foregroundColor(Color(uiColor: .secondaryLabel))
            }.font(.title2.weight(.heavy))
                .padding(.bottom)
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    
    @StateObject static var appVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Ticker.stubs
        return vm
    }()
    
    @StateObject static var emptyAppVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = []
        return vm
    }()
    
    @StateObject static var quotesVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quotesDict = Quote.stubsDict
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
                StockListView(quotesVM: quotesVM)
            }
            .environmentObject(appVM)
            .previewDisplayName("With Tickers")
            
            NavigationStack {
                StockListView(quotesVM: quotesVM)
            }
            .environmentObject(emptyAppVM)
            .previewDisplayName("With Empty Tickers")
        }
        
    }
}
