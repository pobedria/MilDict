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
            
            let terms = lang == "en" ? TermsSorage.enTerms : TermsSorage.ukTerms
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            NavigationView {
                if sanitizedField.isEmpty{
                    TBXListView(terms: terms)
                }
                else {
                    let filtered = terms.filter(
                        where:{ $0.term.lowercased().contains(sanitizedField)},
                        limit: 20).sorted()
                    if filtered.isEmpty {
                        EmptySearchView()
                    } else {
                        TBXListView(terms: filtered)
                    }
                }
            }
            .navigationTitle("Повна інформація")
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
    return TBXTabView(lang: "en")
}
