//
//  MarketsAppApp.swift
//  MarketsApp
//
//  Created by João Gameiro on 31/10/2022.
//

import SwiftUI

@main
struct MarketsApp: App {
    
    @StateObject var appVM = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StockListView()
            }
            .environmentObject(appVM)
        }
    }
}
