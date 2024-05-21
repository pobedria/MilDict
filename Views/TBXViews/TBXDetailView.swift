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
        let termsInConcept = TermsSorage.allTerms.filter({ $0.conceptId == chosenTerm.conceptId })
        let engTerms = termsInConcept.filter({ $0.lang == "en"})
        let ukrTerms = termsInConcept.filter({ $0.lang == "uk"})
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
    let terms = [
        AppTerm(id: 1, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "PsyOp"),
        AppTerm(id: 2, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "psychological operation", description: "Planned activities using methods of communication and other means directed at approved audiences in order to influence perceptions, attitudes and behaviour, affecting the achievement of political and military objectives.", xref: "https://github.com/pobedria/mildictmeta/blob/main/AAP-06.pdf"),
        AppTerm(id: 3, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "uk", term: "інформаційно-психологічна операція"),
        AppTerm(id: 4, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "uk", term: "ІПСО"),
        AppTerm(id: 5, conceptId: 20, subject: "500 – оборонне планування", lang: "en", term: "homeland defense"),
        AppTerm(id: 6, conceptId: 33, subject: "602 – електромагнітна та кіберборотьба", lang: "en", term: "electronic warfare"),
        AppTerm(id: 7, conceptId: 33, subject: "701 – навчально-бойові завдання", lang: "en", term: "OPFOR"),
        AppTerm(id: 9, conceptId: 33, subject: "900 – цивільно-військове співробітництво", lang: "en", term: "humanitarian aid")
    
    ]
    return TBXDetailView(chosenTerm: terms[0])
}
