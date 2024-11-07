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
                    if searchText != ""{
                        ForEach(searchResults) { term in
                            NavigationLink(destination: TBXDetailView(chosenTerm: term)) {
                                TBXPreView(term: term)
                            }
                            .listRowBackground(Color.olive)
                        }
                    } else {
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
                    if searchText != ""{
                        ForEach(searchResults) { term in
                            NavigationLink(destination: TBXDetailView(chosenTerm: term)) {
                                TBXPreView(term: term)
                            }
                            .listRowBackground(Color.olive)
                        }
                    } else {
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
    
  
    private var navigationTitle: String {
        lang == "en" ? "Англійські терміни" : "Українські терміни"
    }
    
    // MARK: - Fuzzy search methods
    func levenshteinDistance(_ s1: String, _ s2: String) -> Int {
        let empty = [Int](repeating: 0, count: s2.count + 1)
        var last = [Int](0...s2.count)
        for (i, c1) in s1.enumerated() {
            var curr = [i + 1] + empty
            for (j, c2) in s2.enumerated() {
                curr[j + 1] = c1 == c2 ? last[j] : min(last[j], last[j + 1], curr[j]) + 1
            }
            last = curr
        }
        return last[s2.count]
    }

    func firstNCharacters(_ text: String, _ n: Int) -> String {
        return String(text.prefix(n))
    }

    private var searchResults: [AppTerm] {
        if searchText.isEmpty {
            return lang == "en" ? TermsStorage.enTerms : TermsStorage.ukTerms
        } else {
            let sanitizedField = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            let searchCharacterCount = sanitizedField.count
            guard searchCharacterCount > 0 else {
                return lang == "en" ? TermsStorage.enTerms : TermsStorage.ukTerms
            }
            
            // Динамічне налаштування максимального допустимого відхилення
            let maximumDistance: Int
            switch searchCharacterCount {
            case 1...3:
                maximumDistance = 1
            case 4...6:
                maximumDistance = 2
            default:
                maximumDistance = 3
            }

            return TermsStorage.allTerms
                .map { term in
                    let termSnippet = firstNCharacters(term.term.lowercased(), searchCharacterCount)
                    let distance = levenshteinDistance(termSnippet, sanitizedField)
                    return (term, distance)
                }
                .filter { $0.1 <= maximumDistance }
                .sorted { $0.1 < $1.1 }
                .map { $0.0 }
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
