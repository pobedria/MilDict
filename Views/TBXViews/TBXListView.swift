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
        .searchable(text: $searchText, prompt: "Пошук термінів")
    }
    
    var searchResults: [AppTerm] {
        if searchText.isEmpty {
            return lang == "en" ? TermsSorage.enTerms : TermsSorage.ukTerms
        } else {
            let sanitizedField = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return TermsSorage.allTerms.filter({ $0.term.lowercased().contains(sanitizedField)}).sorted()
        }
    }
}

#Preview {
    return TBXListView(lang: "en")
}
