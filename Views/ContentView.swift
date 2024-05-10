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
                    Label("Термінологія", systemImage: "text.book.closed")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
            AbbreviationTabView()
                .tabItem {
                    Label("Абревіатури", systemImage: "character.bubble")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
