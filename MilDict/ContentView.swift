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
            TerminologyView()
            
                .tabItem {
                    Label("Термінологія", systemImage: "text.book.closed")
                }

            AbbriviatinView()
                .tabItem {
                    Label("Абревіатури", systemImage: "character.bubble")
                }
        }
    }
}

struct TerminologyView: View {
    @ObservedObject var datas = ReadData()
    @State private var searchfield: String = ""
    var body: some View {
        VStack{
            
            List(datas.users){ user in
                VStack(alignment: .leading) {
                    HStack( alignment: .top){
                        Text(user.ua_title)
                            .font(.title2)

                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text(user.en_title)
                            .font(.title2)
                            .foregroundColor(Color.red)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    
                    Text(user.en_text)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    
                }
            }
        }
    }
}


struct AbbriviatinView: View {
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
