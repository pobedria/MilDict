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
    
    
    init(lang: String) {
        self.lang = lang
        configureSearchBarAppearance()
    }
    
    var body: some View {
        
        NavigationSplitView {
            List(searchResults, selection: $selectedTerm) { term in
                NavigationLink {
                    TBXDetailView(chosenTerm: term)
                } label: {
                    TBXPreView(term: term)
                }.listRowBackground(Color("Olive"))
            }
            .navigationTitle(lang == "en" ? "Англійські терміни" : "Українські терміни")
            
            .scrollContentBackground(.hidden)
            .background(Color("Olive"))
        } detail: {
            TBXDetailView(chosenTerm: selectedTerm ?? TermsStorage.enTerms[0])
                .navigationTitle(" ")// stub fro correct detail alignment
                .navigationBarTitleDisplayMode(.automatic)
        }
//        .toolbarBackground(.hidden)
        .navigationBarColor(backgroundColor: Color("Olive"), titleColor: .white)
        .searchable(text: $searchText, prompt: "Пошук термінів")
        .foregroundColor(Color("Gold"))
        .font(Font.custom("UAFSans-Medium", size: 18))
    }
    
    var searchResults: [AppTerm] {
        
        if searchText.isEmpty {
            return lang == "en" ? TermsStorage.enTerms : TermsStorage.ukTerms
        } else {
            let sanitizedField = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return TermsStorage.allTerms.filter({ $0.term.lowercased().contains(sanitizedField)}).sorted()
        }
    }
    
    private func configureSearchBarAppearance() {
        let textFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        textFieldAppearance.backgroundColor = UIColor(Color("Steppe"))
        textFieldAppearance.tintColor = UIColor(Color("Gold"))
    }
}

#Preview {
    return TBXListView(lang: "en")
}
