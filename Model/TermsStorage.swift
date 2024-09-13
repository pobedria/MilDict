//
//  TermsSorage.swift
//  MilDict
//
//  Created by Viktor Pobedria on 14.05.2024.
//

import Foundation

struct TermsStorage{
    static let allConcepts = decodeConcepts()

    static var enTerms: [AppTerm] {
        return allConcepts.flatMap { $0.enTermsOfConcept()}.sorted()
    }
    
    static var ukTerms: [AppTerm] {
        return allConcepts.flatMap { $0.ukTermsOfConcept()}.sorted()
    }
    
    static var allTerms: [AppTerm] {
        return allConcepts.flatMap { $0.allTermsOfConcept()}.sorted()
    }
}
