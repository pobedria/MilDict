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
    var datas = ReadData()
    @State private var searchfield: String = ""
    
    var body: some View {
        VStack{
            
            if searchfield.isEmpty{
                List(datas.users){ term in
                    TermView(term)
                }
            }
            else {
                if searchfield.isCyrillic{
                    let filtered = datas.users.filter(
                        where:{ $0.ua_title.contains(searchfield)},
                        limit: 20)
                    
                    List(filtered) { term in
                        TermView(term)
                    }
                } else {
                    let filtered = datas.users.filter(
                        where:{ $0.en_title.contains(searchfield)},
                        limit: 20)
//                    var sliced = filtered[0..<min(20,filtered.count)]
                    List(filtered) { term in
                        TermView(term)
                    }
                }
            }
   
            
            TextField("Пошук", text: $searchfield).padding()
        }
    }
}

struct TermView: View {
    
    var term: Term
    init(_ term: Term) {
        self.term = term
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack( alignment: .top){
                Text(term.en_title)
                    .font(.body)
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                if term.ua_title.isEmpty{
                    Text("⚠️ Переклад не стандартизовано")
                        .font(.body)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }else {
                    Text(term.ua_title)
                        .font(.body)
                        .foregroundColor(Color("BackgroundColor"))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            
            Text(term.en_text)
                .font(.subheadline)
                .foregroundColor(Color.gray)
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
