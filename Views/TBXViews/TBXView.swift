//
//  TBXView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import SwiftUI

struct TBXView: View {
    let concept: TBXConcept
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("concept.langSec.first.")
                .font(.body)
                .foregroundColor(Color("Secondary"))
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
}

#Preview {
    let concept = TBXConcept(
        _id: "0",
        descrip: Descrip(_type: "subjectField", __text: "102 – стратегічні комунікації"),
        langSec: [LangElement()]
    )
    
    return TBXView(concept: concept)
}
