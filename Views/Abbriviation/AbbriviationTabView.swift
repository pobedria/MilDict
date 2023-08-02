//
//  AbbriviationTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct AbbriviationTabView: View {
    @State private var searchfield: String = ""
    var body: some View {
        VStack{
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Vikaa")
            Spacer()
            TextField("Пошук", text: $searchfield)
        }.padding()
    }
}

struct AbbriviationTabView_Previews: PreviewProvider {
    static var previews: some View {
        AbbriviationTabView()
    }
}
