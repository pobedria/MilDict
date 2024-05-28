//
//  ContentView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 27.07.2023.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack{
            AppHeader()
            TabView {
                TBXTabView(lang: "en")
                    .tabItem {
                        Label("Англійська🇬🇧", systemImage: "globe.americas.fill")
                    }.toolbarBackground(Color("Olive"),for: .tabBar)
                TBXTabView(lang: "uk")
                    .tabItem {
                        Label("Українська🇺🇦", systemImage: "globe.europe.africa.fill")
                    }.toolbarBackground(Color("Olive"),for: .tabBar)
                QuizTabView()
                    .tabItem {
                        Label("Перевір себе", systemImage: "checklist")
                    }.toolbarBackground(Color("Olive"),for: .tabBar)
            }
        }.background(Color("Olive"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
