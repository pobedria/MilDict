//
//  TerminologyTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI


struct TerminologyTabView: View {
    var terms = loadSortedTerms()
    @State private var searchField: String = ""
    @State private var editing = false
    
    var body: some View {
        VStack{
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            NavigationView {
                if sanitizedField.isEmpty{
                    let words = terms
                    TermsListView(terms: words)
                }
                else {
                    if sanitizedField.isCyrillic{
                        let filtered = terms.filter(
                            where:{ $0.ua_title.lowercased().contains(sanitizedField)},
                            limit: 20)
                        TermsListView(terms: filtered)
                    } else {
                        let filtered = terms.filter(
                            where:{ $0.en_title.lowercased().contains(sanitizedField)},
                            limit: 20)
                        TermsListView(terms: filtered)
                    }
                }
            }.navigationTitle("Landmarks")
            
            TextField("Пошук", text: $searchField, onEditingChanged: { edit in
                self.editing = edit
            })
            .background(Color("Olive"))
            .foregroundColor(searchField.isLatin ? Color("Primary") : Color("Secondary"))
            .textFieldStyle(MDTextFieldStyle(focused: $editing))
            Spacer()
        }.background(Color("Olive"))
    }
}


struct TerminologyTabView_Previews: PreviewProvider {
    static var previews: some View {
        TerminologyTabView()
    }
}
