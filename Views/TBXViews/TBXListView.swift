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
    }
    
    @ViewBuilder
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Використовуємо NavigationSplitView для iPad
            NavigationSplitView {
                List(searchResults, selection: $selectedTerm) { term in
                    NavigationLink(destination: TBXDetailView(chosenTerm: term)) {
                        TBXPreView(term: term)
                    }
                    .listRowBackground(Color.olive)
                }
                .navigationTitle(navigationTitle)
                .scrollContentBackground(.hidden)
                .background(Color.olive)
                .searchable(text: $searchText, prompt: "Пошук термінів")
                .foregroundColor(.gold)
                .font(Font.custom("UAFSans-Medium", size: 18))
            } detail: {
                TBXDetailView(chosenTerm: selectedTerm ?? TermsStorage.enTerms.first!)
//                    .navigationTitle(" ") // Заглушка для коректного вирівнювання
                    .navigationBarTitleDisplayMode(.automatic)
            }
            .navigationBarColor(backgroundColor: .olive, titleColor: .white)
            .onAppear(){
                configureSearchBarAppearance()
            }
        } else {
            // Використовуємо NavigationStack для iPhone
            NavigationStack {
                List(searchResults) { term in
                    NavigationLink(destination: TBXDetailView(chosenTerm: term)) {
                        TBXPreView(term: term)
                    }
                    .listRowBackground(Color.olive)
                }
                .navigationTitle(navigationTitle)
                .scrollContentBackground(.hidden)
                .background(Color.olive)
                .searchable(text: $searchText, prompt: "Пошук термінів")
                .foregroundColor(.olive)
                .font(Font.custom("UAFSans-Medium", size: 18))
                .navigationBarColor(backgroundColor: Color("Olive"), titleColor: .white)
            }.onAppear(){
                configureSearchBarAppearance()
            }
        }
    }
    
    // MARK: - Computed Properties
    private var navigationTitle: String {
        lang == "en" ? "Англійські терміни" : "Українські терміни"
    }
    
    private var searchResults: [AppTerm] {
        
        if searchText.isEmpty {
            return lang == "en" ? TermsStorage.enTerms : TermsStorage.ukTerms
        } else {
            let sanitizedField = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return TermsStorage.allTerms.filter({ $0.term.lowercased().contains(sanitizedField)}).sorted()
        }
    }
    
    // MARK: - Methods
    private func configureSearchBarAppearance() {
        let textFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        textFieldAppearance.backgroundColor = UIColor(.steppe)
        textFieldAppearance.tintColor = UIColor(.gold)
    }
}

#Preview {
    return TBXListView(lang: "en")
}
