//
//  TBXListView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import SwiftUI
import Combine

struct TBXListView: View {
    @StateObject private var viewModel: TBXListViewModel
        
    init(lang: String) {
        _viewModel = StateObject(wrappedValue: TBXListViewModel(lang: lang))
    }
    
    @State private var selectedTerm: AppTerm?
    
    @ViewBuilder
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Використовуємо NavigationSplitView для iPad
            NavigationSplitView {
                List(selection: $selectedTerm) {
                    if !viewModel.searchText.isEmpty {
                        ForEach(viewModel.searchResults) { term in
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
                .searchable(text: $viewModel.searchText, prompt: "Пошук термінів")
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
                    if !viewModel.searchText.isEmpty {
                        ForEach(viewModel.searchResults) { term in
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
                .searchable(text: $viewModel.searchText, prompt: "Пошук термінів")
                .foregroundColor(.gold)
                .font(Font.custom("UAFSans-Medium", size: 18))
                .navigationBarColor(backgroundColor: Color("Olive"), titleColor: .white)
                
            }.onAppear(){
               
                configureSearchBarAppearance()
            }
      
        }
    }
    
    private var navigationTitle: String {
        viewModel.lang == "en" ? "Англійські терміни" : "Українські терміни"
    }

    private func configureSearchBarAppearance() {
        let textFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        textFieldAppearance.backgroundColor = UIColor(.steppe)
        textFieldAppearance.tintColor = UIColor(.gold)
    }
    
    private var groupedTerms: [(key: String, values: [AppTerm])] {
        let terms = viewModel.searchResults
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
