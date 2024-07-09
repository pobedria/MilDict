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
                    .foregroundColor(Color("Gold"))
                    .font(Font.custom("UAFSans-Medium", size: 25))
            }

            Text(getDescription(terms: terms))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .foregroundColor(.white)
                .font(Font.custom("UAFSans-Regular", size: 15))

            
            let link = getXref(terms: terms)
            if let linkName = linksDict[link] {
                Text(.init("[\nДжерело: \(linkName)](\(link)) 🔗"))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .accentColor(Color("Gold"))
                    .font(Font.custom("UAFSans-Regular", size: 12))
            } else {
                if let url = NSURL(string: link) {
                    if UIApplication.shared.canOpenURL(url as URL){
                        Text(.init("[\nДжерело: \(link)](\(link)) 🔗"))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .accentColor(Color("Gold"))
                            .font(Font.custom("UAFSans-Regular", size: 12))
                    }
                    else {
                        Text("\nДжерело: \(link)")
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .foregroundColor(Color("Gold"))
                            .font(Font.custom("UAFSans-Regular", size: 12))
                    }
                }
            }
            Spacer()
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
