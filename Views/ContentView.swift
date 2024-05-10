//
//  ContentView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TBXTabViewUA()
                .tabItem {
                    Label("Англійська🇬🇧", systemImage: "bus.doubledecker.fill")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
            AbbreviationTabView()
                .tabItem {
                    Label("Українська🇺🇦", systemImage: "globe")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
