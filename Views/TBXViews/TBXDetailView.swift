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
        let chosenConcept = TermsStorage.allConcepts.first(where: { $0.id == chosenTerm.conceptId})!
        let engTerms = chosenConcept.enTermsOfConcept()
        let ukrTerms = chosenConcept.ukTermsOfConcept()
        let topTerms = chosenTerm.lang == "en" ? engTerms : ukrTerms
        let bottomTerms = chosenTerm.lang == "en" ? ukrTerms : engTerms
        let link = getXref(terms: ukrTerms)
        
        ZStack{
            VStack {
                TermDetailView(terms: topTerms)
                Divider()
                    .background(Color.gold)
                TermDetailView(terms: bottomTerms)
                Text(chosenTerm.subject)
                    .font(Font.custom("UAFSans-Bold", size: 15))
                    .foregroundColor(.steppe)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal)
            .background(Color.olive)
            
            if let linkName = linksDict[link] {
                if linkName.contains("ВСТ"){
                   StandartizedSealView()
                        .opacity(0.2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.bottom, -30)
                        .padding(.trailing, -50)
                }
            }
        }
    }
    
    func getXref(terms: [AppTerm]) -> String {
        for term in terms {
            if let xref = term.xref{
                return xref
            }
        }
        return ""
    }
}

#Preview {
    let term = AppTerm(id: 1, conceptId: 326712, subject: "102 – стратегічні комунікації", lang: "en", term: "PsyOp")
    
    return TBXDetailView(chosenTerm: term)
}
