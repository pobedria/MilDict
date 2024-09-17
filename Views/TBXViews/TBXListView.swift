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
                List(selection: $selectedTerm) {
                    ForEach(groupedTerms, id: \.key) { section in
                        Section(header: SectionHeaderView(headerText:section.key)) {
                            ForEach(section.values) { term in
                                NavigationLink(destination: TBXDetailView(chosenTerm: term)) {
                                    TBXPreView(term: term)
                                }
                                .listRowBackground(Color.olive)
                            }
                        }
                        .headerProminence(.increased)
                    }
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
                List {
                    ForEach(groupedTerms, id: \.key) { section in
                        Section(header: SectionHeaderView(headerText:section.key)) {
                            ForEach(section.values) { term in
                                NavigationLink(destination: TBXDetailView(chosenTerm: term)) {
                                    TBXPreView(term: term)
                                }
                                .listRowBackground(Color.olive)
                            }
                        }
                        .headerProminence(.standard)
                    }
                }
                .navigationTitle(navigationTitle)
                .scrollContentBackground(.hidden)
                .background(Color.olive)
                .searchable(text: $searchText, prompt: "Пошук термінів")
                .foregroundColor(.gold)
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
            return TermsStorage.allTerms.filter({ $0.term.lowercased().starts(with:sanitizedField)}).sorted()
        }
    }
    
    // MARK: - Methods
    private func configureSearchBarAppearance() {
        let textFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        textFieldAppearance.backgroundColor = UIColor(.steppe)
        textFieldAppearance.tintColor = UIColor(.gold)
    }
    
    private var groupedTerms: [(key: String, values: [AppTerm])] {
        let terms = searchResults
        let grouped = Dictionary(grouping: terms) { term -> String in
            let firstLetter = term.term.prefix(1).uppercased()
            return firstLetter
        }
        let ukrainianLocale = Locale(identifier: "uk_UA")
            return grouped.sorted { (lhs, rhs) -> Bool in
                return lhs.key.compare(rhs.key, locale: ukrainianLocale) == .orderedAscending
            }.map { (key: $0.key, values: $0.value) }
    }
}

struct SectionHeaderView: View {
    var headerText: String

    var body: some View {
        Text(headerText)
            .foregroundColor(.steppe)
            .font(.custom("Volja-Regular", size: 30))

    }
}

#Preview {
    return TBXListView(lang: "en")
}
