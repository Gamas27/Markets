//
//  ContentView.swift
//  MarketsApp
//
//  Created by João Gameiro on 31/10/2022.
//

import SwiftUI

struct MainListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}