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
            TBXTabViewEN()
                .tabItem {
                    Label("Англійська🇬🇧", systemImage: "globe.americas.fill")
                }.toolbarBackground(Color("Olive"),for: .tabBar)
            TBXTabViewUA()
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
