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
            
            if searchfield.isEmpty{
                List(datas.users.sorted{$0.ua_title < $1.ua_title}){ term in
                    TermView(term)
                }
            }
            else {
                if searchfield.isCyrillic{
                    List(datas.users.filter({ $0.ua_title.contains(searchfield)}).sorted{$0.ua_title < $1.ua_title}) { term in
                        TermView(term)
                    }
                } else {
                    List(datas.users.filter({ $0.en_title.contains(searchfield)}).sorted{$0.en_title < $1.en_title}) { term in
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
                Text(term.ua_title)
                    .font(.body)
                    .foregroundColor(Color("BackgroundColor"))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(term.en_title)
                    .font(.body)
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
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
