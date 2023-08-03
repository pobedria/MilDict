//
//  AbbriviationTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct AbbreviationTabView: View {
    @State private var editing = false
    var abbreviations = loadAbbreviations()
    @State private var searchField: String = ""
    var body: some View {
        VStack{
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            NavigationView {
                if sanitizedField.isEmpty{
                    let words = abbreviations
                    AbbreviationListView(abbreviations: words)
                }
                else {
                    let filtered = abbreviations.filter(
                        where:{ $0.short_title.lowercased().contains(sanitizedField)},
                        limit: 20)
                    AbbreviationListView(abbreviations: filtered)
                }
            }
            .navigationTitle("Аббревіатури")
            TextField("Пошук", text: $searchField, onEditingChanged: { edit in
                self.editing = edit
            }).background(Color("Olive"))
            .textFieldStyle(MDTextFieldStyle(focused: $editing))
            Spacer()
        }.background(Color("Olive"))
    }
}

struct AbbreviationTabView_Previews: PreviewProvider {
    static var previews: some View {
        AbbreviationTabView()
    }
}
