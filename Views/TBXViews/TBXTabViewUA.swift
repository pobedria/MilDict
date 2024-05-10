//
//  TBXTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 10.05.2024.
//

import SwiftUI

struct TBXTabViewUA: View {
    @State private var searchField: String = ""
    var terms = loadAppTerms()
    
    var body: some View {
        VStack() {
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            NavigationView {
                if sanitizedField.isEmpty{
                    let words = terms
                    TBXListView(terms: words)
                }
                else {
                    let filtered = terms.filter(
                        where:{ $0.term.lowercased().contains(sanitizedField)},
                        limit: 20)
                    TBXListView(terms: filtered)
                }
            }
            .navigationTitle("UK")
            TextField("Пошук", text: $searchField,prompt:  Text("Пошук").foregroundColor(Color("LightKhaki")))
                .background(Color("Olive"))
                .textFieldStyle(MDTextFieldStyle())
                .foregroundColor(Color("Gold"))
            Spacer()
        }.background(Color("Olive"))
    }
}

#Preview {
    TBXTabViewUA()
}
