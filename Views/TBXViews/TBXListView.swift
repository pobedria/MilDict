//
//  TBXListView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import SwiftUI

struct TBXListView: View {
    @State private var selectedTerm: AppTerm?
    let terms: [AppTerm]

    var body: some View {
//        NavigationView {
//            List(terms){ term in
//                NavigationLink {
//                    TBXDetailView(chosenTerm: term)
//                } label: {
//                    TBXPreView(term: term)
//                }.listRowBackground(Color("Olive"))
//            }.background(Color("Olive"))
//            .scrollContentBackground(.hidden)
//           
//        }
//        .foregroundColor(Color("Gold"))
        
//        NavigationStack {
//            List(terms) { term in
//                
//                NavigationLink {
//                    TBXDetailView(chosenTerm: term)
//                } label: {
//                    TBXPreView(term: term)
//                }.listRowBackground(Color("Olive"))
//            }.background(Color("Olive"))
//                .scrollContentBackground(.hidden)
//        }
        
        NavigationSplitView {
            List(terms, selection: $selectedTerm) { term in
                NavigationLink {
                    TBXDetailView(chosenTerm: term)
                } label: {
                    TBXPreView(term: term)
                }.listRowBackground(Color("Olive"))
            }.background(Color("Olive"))
                .scrollContentBackground(.hidden)
        } detail: {
            TBXDetailView(chosenTerm: selectedTerm ?? terms[0])
        }.navigationTitle("Terms")
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
    return TBXListView(terms: terms)
}
