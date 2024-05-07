//
//  TBXModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 07.05.2024.
//

import Foundation

import Foundation

struct TBXConcept: Codable, Identifiable {
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


struct Descrip: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case _type
        case __text
    }
    var id: Int
    var _type: String
    var __text: String
}
