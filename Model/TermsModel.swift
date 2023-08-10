//
//  WordsModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation

struct Term: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case en_title
        case en_text
        case ua_title
        case ua_text
    }
    
    var id: Int
    var en_title: String
    var en_text: String
    var ua_title: String
    var ua_text: String
    
}
