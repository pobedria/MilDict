//
//  TBXTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 10.05.2024.
//

import SwiftUI

struct TBXTabView: View {
    @State private var searchField: String = ""
    let lang: String
    
    var body: some View {
        VStack() {
            
            
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if sanitizedField.isEmpty{
                let termsByLanguge = lang == "en" ? TermsSorage.enTerms : TermsSorage.ukTerms
                TBXListView(terms: termsByLanguge)
            }
            else {
                let allTerms = TermsSorage.allTerms
                let filtered = allTerms.filter(
                    where:{ $0.term.lowercased().contains(sanitizedField)},
                    limit: 20).sorted()
                if filtered.isEmpty {
                    EmptySearchView()
                } else {
                    TBXListView(terms: filtered)
                }
            }
 
            TextField("Пошук", text: $searchField,prompt:  Text("Пошук").foregroundColor(Color("LightKhaki")))
                .background(Color("Olive"))
                .textFieldStyle(MDTextFieldStyle())
                .foregroundColor(Color("Gold"))
            Spacer()
        }.background(Color("Olive"))
    }
}

#Preview {
    return TBXTabView(lang: "en")
}
