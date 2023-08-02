//
//  TermsList.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct TermsListView: View {
    let terms: [Term]
    
    var body: some View {
        List(terms){ term in
            NavigationLink {
                TermDetailView(term: term)
            } label: {
                TermView(term: term)
            }
        }
    }
}

struct TermsListView_Previews: PreviewProvider {
    static var previews: some View {
        TermsListView(terms:
            [Term(
                id: 1,
                en_title: "LOCAL AREA NETWORK",
                en_text: "",
                ua_title: "МЕРЕЖА ЛОКАЛЬНА",
                ua_text: ""
            ),
             Term(
                 id: 2,
                 en_title: "LOCAL AREA NETWORK",
                 en_text: "",
                 ua_title: "МЕРЕЖА ЛОКАЛЬНА",
                 ua_text: ""
             )
            ]
        )
    }
}
