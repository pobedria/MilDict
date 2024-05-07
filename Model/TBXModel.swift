//
//  TBXModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 07.05.2024.
//

import Foundation

import Foundation

struct TBXConcept: Decodable{
    enum CodingKeys: CodingKey {
        case _id, descrip
    }
    
    var _id: String
    var descrip: Descrip
}


struct Descrip: Codable{
    enum CodingKeys: CodingKey {

        case _type
        case __text
    }
    var _type: String
    var __text: String
}
