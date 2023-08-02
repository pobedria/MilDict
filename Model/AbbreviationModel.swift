//
//  AbbreviationModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 02.08.2023.
//

import Foundation

struct Abbreviation: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case short_title
        case en_title
        case ua_title
        case source
    }
    
    var id: Int
    var short_title: String
    var en_title: String
    var ua_title: String
    var source: String
}
