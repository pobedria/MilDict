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
        VStack(alignment: .leading){
            Text(abbreviation.short_title).foregroundColor(Color("Primary"))
                .font(.title)
            Divider()
            Text(abbreviation.en_title)
                .foregroundColor(Color("Primary"))
                .font(.title)

            Text(abbreviation.ua_title)
                .font(.headline)
                .foregroundColor(Color("Secondary"))
            Divider()
            Text("Джерело: \(abbreviation.source)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .background(Color("Olive"))
        
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
