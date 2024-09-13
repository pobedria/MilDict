//
//  TBXModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 07.05.2024.
//

import Foundation

import Foundation

struct TBXConcept: Decodable{
    let id: Int
    let descrip: Descrip
    let langSec: [LangElement]
    
    
    enum CodingKeys:  CodingKey {
        case id, descrip, langSec
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = Int(try values.decode(String.self, forKey: .id))!
        descrip = try values.decode(Descrip.self, forKey: .descrip)
        langSec = try values.decode([LangElement].self, forKey: .langSec)
    }
    
    func enTermsOfConcept() -> [AppTerm] {
        return termsOfLangElement(langElement: langSec[0])
    }
    
    func ukTermsOfConcept() -> [AppTerm] {
        return termsOfLangElement(langElement: langSec[1])
    }
    
    func allTermsOfConcept() -> [AppTerm] {
        return ukTermsOfConcept() + enTermsOfConcept()
    }
    
    
    func termsOfLangElement(langElement: LangElement) -> [AppTerm] {
        var terms = [AppTerm]()
        switch langElement.termSec {
        case .single(let termElement):
            if let appTerm = createAppTerm(from: termElement, langElement: langElement) {
                terms.append(appTerm)
            }
        case .multiple(let termArray):
            for termElement in termArray {
                if let appTerm = createAppTerm(from: termElement, langElement: langElement) {
                    terms.append(appTerm)
                }
            }
        }
        return terms
    }

    private func createAppTerm(from termElement: TermSecElement, langElement: LangElement) -> AppTerm? {
        guard let termId = Int(termElement.term.id) else { return nil }
        return AppTerm(
            id: termId,
            conceptId: id,
            subject: descrip._text,
            lang: langElement.lang,
            term: termElement.term._text,
            description: termElement.descrip?._text,
            xref: termElement.xref?.target
        )
    }
}


struct Descrip: Decodable {
    let type: String
    let _text: String
}


struct LangElement: Decodable{
    let termSec: TermSec
    let lang: String
    
    enum CodingKeys: String, CodingKey {
        case termSec
        case lang  = "xml:lang"
    }
}

enum TermSec: Decodable {
    case single(TermSecElement)
    case multiple([TermSecElement])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let singleTermSec = try? container.decode(TermSecElement.self) {
            self = .single(singleTermSec)
        } else if let multipleTermSec = try? container.decode([TermSecElement].self) {
            self = .multiple(multipleTermSec)
        } else {
            throw DecodingError.typeMismatch(TermSec.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Не вдалося декодувати termSec"))
        }
    }
}

struct TermSecElement: Decodable {
    let term: TBXTerm
    let descrip: Descrip?
    let xref: TBXxref?
}

struct TBXTerm: Decodable{
    let id: String
    let _text: String
}

struct TBXxref: Decodable {
    let type: String
    let target: String
}
