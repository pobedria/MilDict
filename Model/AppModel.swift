//
//  AppModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 08.05.2024.
//

import Foundation

struct AppTerm: Identifiable, Comparable, Hashable {
    var id: Int
    var conceptId: Int
    var subject: String
    var lang: String
    var term: String
    var description: String?
    var xref: String?
    
    static func < (lhs: AppTerm, rhs: AppTerm) -> Bool {
        return lhs.term.localizedCaseInsensitiveCompare(rhs.term) == .orderedAscending
    }
}

