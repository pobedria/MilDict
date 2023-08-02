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
            TerminologyTabView()
                .tabItem {
                    Label("Термінологія", systemImage: "text.book.closed")
                }
            AbbreviationTabView()
                .tabItem {
                    Label("Абревіатури", systemImage: "character.bubble")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
