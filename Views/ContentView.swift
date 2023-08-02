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

            AbbriviationView()
                .tabItem {
                    Label("Абревіатури", systemImage: "character.bubble")
                }
        }
    }
}

struct AbbriviationView: View {
    @State private var searchfield: String = ""
    var body: some View {
        VStack{
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Vikaa")
            Spacer()
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $searchfield)
        }.padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
