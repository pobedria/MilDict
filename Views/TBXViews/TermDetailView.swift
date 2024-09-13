//
//  TermDetailView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 13.05.2024.
//

import SwiftUI

struct TermDetailView: View {
    // MARK: - Properties
    let terms: [AppTerm]
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(terms) { term in
                TermTextView(term: term)
            }
            
            if let description = termDescription {
                Text(description)
                    .foregroundColor(.white)
                    .font(.custom("UAFSans-Regular", size: 15))
            }
            
            if let sourceText = sourceText {
                Text(.init(sourceText))
                    .accentColor(.gold)
                    .font(.custom("UAFSans-Regular", size: 12))
            }
            
            Spacer()
        }
    
        .textSelection(.enabled)
    }
    
    // MARK: - Computed Properties
    private var termDescription: String? {
        terms.first(where: { $0.description != nil })?.description?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var xrefLink: String? {
        terms.first(where: { $0.xref != nil })?.xref
    }
    
    private var sourceText: String? {
        guard let link = xrefLink else { return nil }
        
        if let linkName = linksDict[link] {
            return "[\nДжерело: \(linkName)](\(link)) 🔗"
        } else if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            return "[\nДжерело: \(link)](\(link)) 🔗"
        } else {
            return "\nДжерело: \(link)"
        }
    }
}

#Preview {
    let terms = [
        AppTerm(id: 1, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "PsyOp"),
        AppTerm(id: 2, conceptId: 10, subject: "102 – стратегічні комунікації", lang: "en", term: "psychological operation", description: "Planned activities using methods of communication and other means directed at approved audiences in order to influence perceptions, attitudes and behaviour, affecting the achievement of political and military objectives.", xref: "https://github.com/pobedria/mildictmeta/blob/main/AAP-06.pdf"),
    
    ]
    return TermDetailView(terms: terms)
}
