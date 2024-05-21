//
//  TermsSorage.swift
//  MilDict
//
//  Created by Viktor Pobedria on 14.05.2024.
//

import Foundation

struct TermsSorage{
    static let allConcepts = decodeConcepts()
    static let allTerms = transformConceptsToTerms(allConcepts)
//    static let enTerms = allTerms.filter({ $0.lang == "en"})
//    static let ukTerms = allTerms.filter({ $0.lang == "uk"})
}
