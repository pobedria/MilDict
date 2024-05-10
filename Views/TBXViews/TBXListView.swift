//
//  TBXListView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import SwiftUI

struct TBXListView: View {
    let terms: [AppTerm]
    
    var body: some View {
        List(terms){ term in
            NavigationLink {
                Text(term.term)
            } label: {
                TBXPreView(term: term)
            }.listRowBackground(Color("Olive"))
        }.background(Color("Steppe"))
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    let terms = [
        AppTerm(id: 1, conceptId: 33, subject: "104 – військова кадрова політика", lang: "en", term: "PsyOp"),
        AppTerm(id: 2, conceptId: 33, subject: "202 – зовнішня розвідка", lang: "en", term: "agent"),
        AppTerm(id: 3, conceptId: 33, subject: "104 – військова кадрова політика", lang: "en", term: "Trololo"),
        AppTerm(id: 4, conceptId: 33, subject: "104 – військова кадрова політика", lang: "en", term: "Trololo"),
        AppTerm(id: 5, conceptId: 33, subject: "104 – військова кадрова політика", lang: "en", term: "Trololo"),
        AppTerm(id: 6, conceptId: 33, subject: "104 – військова кадрова політика", lang: "en", term: "Trololo")
    
    ]
    return TBXListView(terms: terms)
}
