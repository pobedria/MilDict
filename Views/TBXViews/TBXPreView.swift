//
//  TBXView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import SwiftUI

struct TBXPreView: View {
    let term: AppTerm
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(term.term)
                .font(Font.custom("UAFSans-Medium", size: 20))
                .foregroundColor(.gold)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            Text(term.subject)
                .font(Font.custom("UAFSans-Medium", size: 12))
                .foregroundColor(.steppe)
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}

#Preview {
    let term = AppTerm(id: 3, conceptId: 33, subject: "104 – військова кадрова політика", lang: "en", term: "Trololo")
    
    return TBXPreView(term: term)
}
