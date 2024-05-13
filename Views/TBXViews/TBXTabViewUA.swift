//
//  TBXTabViewUA.swift
//  MilDict
//
//  Created by Viktor Pobedria on 13.05.2024.
//

import SwiftUI

struct TBXTabViewUA: View {
    @State private var searchField: String = ""
    var terms: [AppTerm]
    
    var body: some View {
        VStack() {
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let ukrTerms = terms.filter({ $0.lang == "uk"}).sorted()
            NavigationView {
                if sanitizedField.isEmpty{
                    TBXListView(terms: ukrTerms)
                }
                else {
                    let filtered = ukrTerms.filter(
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
        AppTerm(id: 1, conceptId: 33, subject: "102 – стратегічні комунікації", lang: "uk", term: "ІПСО"),
        AppTerm(id: 2, conceptId: 33, subject: "202 – зовнішня розвідка", lang: "uk", term: "агент"),
        AppTerm(id: 3, conceptId: 33, subject: "300 – оперативне управління (штабні процедури)", lang: "uk", term: "управління військами"),
        AppTerm(id: 4, conceptId: 33, subject: "432 – боєприпаси та вибухові речовини", lang: "uk", term: "система підриву"),
        AppTerm(id: 5, conceptId: 33, subject: "500 – оборонне планування", lang: "uk", term: "територіальна оборона"),
        AppTerm(id: 6, conceptId: 33, subject: "602 – електромагнітна та кіберборотьба", lang: "uk", term: "РЕБ"),
        AppTerm(id: 7, conceptId: 33, subject: "701 – навчально-бойові завдання", lang: "uk", term: "умовний противник"),
        AppTerm(id: 9, conceptId: 33, subject: "900 – цивільно-військове співробітництво", lang: "uk", term: "гуманітарна допомога")
    
    ]
    return TBXTabViewUA(terms: terms)
}
