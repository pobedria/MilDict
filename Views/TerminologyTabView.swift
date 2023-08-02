//
//  TerminologyTabView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct TerminologyTabView: View {
    var datas = ReadData()
    @State private var searchField: String = ""
    
    var body: some View {
        VStack{
            let sanitizedField = searchField
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
            NavigationView {
                if sanitizedField.isEmpty{
                    let words = datas.terms
                    List(words){ term in
                        NavigationLink {
                            TermDetail(term: term)
                        } label: {
                            TermView(term)
                        }
                    }
                }
                else {
                    if sanitizedField.isCyrillic{
                        let filtered = datas.terms.filter(
                            where:{ $0.ua_title.lowercased().contains(sanitizedField)},
                            limit: 20)
                        List(filtered) { term in
                            TermView(term)
                        }
                    } else {
                        let filtered = datas.terms.filter(
                            where:{ $0.en_title.lowercased().contains(sanitizedField)},
                            limit: 20)
                        List(filtered) { term in
                            TermView(term)
                        }
                    }
                }
            }.navigationTitle("Landmarks")
   
            TextField("Пошук", text: $searchField).padding()
        }
    }
}


struct TerminologyTabView_Previews: PreviewProvider {
    static var previews: some View {
        TerminologyTabView()
    }
}
