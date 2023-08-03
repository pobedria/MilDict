//
//  AbbreviationView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct AbbreviationView: View {
    let abbreviation: Abbreviation
    var body: some View {
        Text(abbreviation.short_title).foregroundColor(.accentColor)
    }
}

struct AbbreviationView_Previews: PreviewProvider {
    static var previews: some View {
        AbbreviationView(abbreviation:
            Abbreviation(id: 1, short_title: "ABC", en_title: "Alpabeth", ua_title: "Абетка", source: "My source"
            )
        )
    }
}
