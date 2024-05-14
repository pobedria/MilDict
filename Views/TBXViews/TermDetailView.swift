//
//  TermDetailView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 13.05.2024.
//

import SwiftUI

struct TermDetailView: View {
    let terms: [AppTerm]
    var body: some View {
        VStack{
            ForEach(terms) {
                Text( $0.term)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .foregroundColor(Color("Salad")).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }

            Text(getDescription(terms: terms))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(Color("Gold"))
            Spacer()
            
            let link = getXref(terms: terms)
            let linkName = linksDict[link]
            Text(.init("[🔗\(linkName ?? link)](\(link))"))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .accentColor(Color("LinkColor"))
    
        
        }.textSelection(.enabled)
    }
    
    func getDescription(terms: [AppTerm]) -> String {
        for term in terms {
            if let description = term.description{
                return description.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        return ""
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
    let terms = [
        AppTerm(id: 1, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "PsyOp"),
        AppTerm(id: 2, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "psychological operation", description: "Planned activities using methods of communication and other means directed at approved audiences in order to influence perceptions, attitudes and behaviour, affecting the achievement of political and military objectives.", xref: "https://github.com/pobedria/mildictmeta/blob/main/AAP-06.pdf"),
    
    ]
    return TermDetailView(terms: terms)
}
