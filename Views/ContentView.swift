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
                TBXListView(lang: "en")
                    .tabItem {
                        Label("Англійська🇬🇧", systemImage: "globe.americas.fill")
                    }
                    .toolbarBackground(Color.olive,for: .tabBar)
                TBXListView(lang: "uk")
                    .tabItem {
                        Label("Українська🇺🇦", systemImage: "globe.europe.africa.fill")
                    }
                    .toolbarBackground(Color.olive,for: .tabBar)
                QuizTabView()
                    .tabItem {
                        Label("Перевір себе", systemImage: "checklist")
                    }
                    .toolbarBackground(Color.olive,for: .tabBar)
            }.background(Color.olive)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
