//
//  TBXModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 07.05.2024.
//

import Foundation

import Foundation

struct TBXConcept: Decodable{
    let _id: String
    let descrip: Descrip
    let langSec: [LangElement]
}


struct Descrip: Decodable {
    let _type: String
    let __text: String
}


struct LangElement: Decodable{
    let termSec: Any
    let lang: String
    
    enum CodingKeys: String, CodingKey {
        case termSec
        case lang  = "_xml:lang"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        
        lang = try values.decode(String.self, forKey: .lang)
        
        if let str = try? values.decode(TermSecElement.self, forKey: .termSec) {
            termSec = str
        } else if let content = try? values.decode([TermSecElement].self, forKey: .termSec) {
            termSec = content
        } else {
            throw DecodingError.dataCorruptedError(forKey:.termSec, in: values, debugDescription: "Value cannot be decoded!")
        }
    }
}

struct TermSecElement: Decodable {
    let term: TBXTerm
    let descrip: Descrip?
    let xref: TBXxref?
}

struct TBXTerm: Decodable{
    let _id: String
    let __text: String
}

struct TBXxref: Decodable {
    let _type: String
    let _target: String
}
