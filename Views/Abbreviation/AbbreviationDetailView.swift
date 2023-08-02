//
//  AbbreviationDetailView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import SwiftUI

struct AbbreviationDetailView: View {
    let abbreviation: Abbreviation
    var body: some View {
        VStack{
            Text(abbreviation.short_title)
            Text(abbreviation.en_title)
        }
        
    }
}

struct AbbreviationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AbbreviationDetailView(abbreviation:
            Abbreviation(id: 1, short_title: "ABC", en_title: "Alpabeth", ua_title: "Абетка", source: "My source"
            )
        )
    }
}
