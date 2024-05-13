//
//  ContentView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    var terms = loadAppTerms()
    var body: some View {
        TabView {
            TBXTabViewEN(terms:terms)
                .tabItem {
                    Label("Англійська🇬🇧", systemImage: "globe.americas.fill")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
            TBXTabViewUA(terms:terms)
                .tabItem {
                    Label("Українська🇺🇦", systemImage: "globe.europe.africa.fill")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
