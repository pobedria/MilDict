//
//  AbbreviationListView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct AbbreviationListView: View {
    let abbreviations: [Abbreviation]
    
    var body: some View {
        List(abbreviations){ abbreviation in
            NavigationLink {
                AbbreviationDetailView(abbreviation: abbreviation)
            } label: {
                AbbreviationView(abbreviation: abbreviation)
            }.listRowBackground(Color("Olive"))
        }.background(Color("Steppe"))
        .scrollContentBackground(.hidden)
    }
}

struct AbbreviationListView_Previews: PreviewProvider {
    static var previews: some View {
        AbbreviationListView(abbreviations:
            [Abbreviation(id: 1, short_title: "ABC", en_title: "Alpabeth", ua_title: "Абетка", source: "My source"
                         ),
             Abbreviation(id: 2, short_title: "ABC", en_title: "Alpabeth", ua_title: "Абетка", source: "My source"
                          ),
            ]
        )
    }
}
