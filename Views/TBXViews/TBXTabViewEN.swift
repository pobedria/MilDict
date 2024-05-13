//
//  TBXTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 10.05.2024.
//

import SwiftUI

struct TBXTabViewEN: View {
    @State private var searchField: String = ""
    var terms: [AppTerm]
    
    var body: some View {
        VStack() {
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let engTerms = terms.filter({ $0.lang == "en"}).sorted()
            NavigationView {
                if sanitizedField.isEmpty{
                    TBXListView(terms: engTerms)
                }
                else {
                    let filtered = engTerms.filter(
                        where:{ $0.term.lowercased().contains(sanitizedField)},
                        limit: 20).sorted()
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
    let terms = [
        AppTerm(id: 1, conceptId: 33, subject: "102 – стратегічні комунікації", lang: "en", term: "PsyOp"),
        AppTerm(id: 2, conceptId: 33, subject: "202 – зовнішня розвідка", lang: "en", term: "agent"),
        AppTerm(id: 3, conceptId: 33, subject: "300 – оперативне управління (штабні процедури)", lang: "en", term: "C2"),
        AppTerm(id: 4, conceptId: 33, subject: "432 – боєприпаси та вибухові речовини", lang: "en", term: "demolition system"),
        AppTerm(id: 5, conceptId: 33, subject: "500 – оборонне планування", lang: "en", term: "homeland defense"),
        AppTerm(id: 6, conceptId: 33, subject: "602 – електромагнітна та кіберборотьба", lang: "en", term: "electronic warfare"),
        AppTerm(id: 7, conceptId: 33, subject: "701 – навчально-бойові завдання", lang: "en", term: "OPFOR"),
        AppTerm(id: 9, conceptId: 33, subject: "900 – цивільно-військове співробітництво", lang: "en", term: "humanitarian aid")
    
    ]
    return TBXTabViewEN(terms: terms)
}
