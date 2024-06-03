//
//  TBXListView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import SwiftUI

struct TBXListView: View {
    @State private var selectedTerm: AppTerm?
    @State private var searchText = ""
    let lang: String
    
    var body: some View {
        
        NavigationSplitView {
            List(searchResults, selection: $selectedTerm) { term in
                NavigationLink {
                    TBXDetailView(chosenTerm: term)
                } label: {
                    TBXPreView(term: term)
                }.listRowBackground(Color("Olive"))
            }
            .scrollContentBackground(.hidden)
            .background(Color("Olive"))
        } detail: {
            TBXDetailView(chosenTerm: selectedTerm ?? TermsSorage.enTerms[0])
        }
        .navigationBarColor(UIColor(Color("Olive")))
        .searchable(text: $searchText, prompt: "Look for something")
    }
    
    var searchResults: [AppTerm] {
        if searchText.isEmpty {
            return lang == "en" ? TermsSorage.enTerms : TermsSorage.ukTerms
        } else {
            let sanitizedField = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return TermsSorage.allTerms.filter(
                where:{ $0.term.lowercased().contains(sanitizedField)},
                limit: 20).sorted()
        }
    }
}

#Preview {
    let terms = [
        AppTerm(id: 1, conceptId: 326712, subject: "104 – військова кадрова політика", lang: "en", term: "PsyOp"),
        AppTerm(id: 2, conceptId: 326080, subject: "202 – зовнішня розвідка", lang: "en", term: "agent"),
        AppTerm(id: 3, conceptId: 330696, subject: "300 – оперативне управління (штабні процедури)", lang: "en", term: "C2"),
        AppTerm(id: 4, conceptId: 329900, subject: "432 – боєприпаси та вибухові речовини", lang: "en", term: "demolition system"),
        AppTerm(id: 5, conceptId: 330690, subject: "500 – оборонне планування", lang: "en", term: "homeland defense"),
        AppTerm(id: 6, conceptId: 326718, subject: "602 – електромагнітна та кіберборотьба", lang: "en", term: "electronic warfare"),
        AppTerm(id: 7, conceptId: 326944, subject: "701 – навчально-бойові завдання", lang: "en", term: "OPFOR"),
        AppTerm(id: 9, conceptId: 326262, subject: "900 – цивільно-військове співробітництво", lang: "en", term: "humanitarian aid")
        
    ]
    return TBXListView(lang: "en")
}
