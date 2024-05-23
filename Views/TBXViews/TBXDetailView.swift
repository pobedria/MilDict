//
//  TDXDetailView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 13.05.2024.
//

import SwiftUI

struct TBXDetailView: View {

    let chosenTerm: AppTerm

    var body: some View {
        let chosenConcept = TermsSorage.allConcepts.filter({ $0.id == chosenTerm.conceptId})[0]
        let engTerms = chosenConcept.enTermsOfConcept()
        let ukrTerms = chosenConcept.ukTermsOfConcept()
        let topTerms = chosenTerm.lang == "en" ? engTerms : ukrTerms
        let botomTerms = chosenTerm.lang == "en" ? ukrTerms : engTerms
        VStack {
            TermDetailView(terms: topTerms)
            Divider()
                .background(Color("Gold"))
            TermDetailView(terms: botomTerms)
            Text(chosenTerm.subject)
                .font(Font.custom("UAFSans-Bold", size: 15))
                .foregroundColor(Color("Steppe"))
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding()
        .background(Color("Olive"))
        
        
        
    }
}

#Preview {
    let term = AppTerm(id: 1, conceptId: 326712, subject: "102 – стратегічні комунікації", lang: "en", term: "PsyOp")
    
    return TBXDetailView(chosenTerm: term)
}
