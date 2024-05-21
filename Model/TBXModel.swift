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
    
    func enTermsOfConcept () -> [AppTerm] {
        return termsOfLangElement(langElement: langSec[0])
    }
    
    func ukTermsOfConcept () -> [AppTerm] {
        return termsOfLangElement(langElement: langSec[1])
    }
    
    func termsOfLangElement(langElement: LangElement) -> [AppTerm] {
        var terms = [AppTerm]()
        if let termArray = langElement.termSec as? [TermSecElement] {
            for termElement in termArray{
                let appTerm = AppTerm(
                    id: Int(termElement.term.id)!,
                    conceptId: id,
                    subject: descrip._text,
                    lang: langElement.lang,
                    term: termElement.term._text,
                    description: termElement.descrip?._text,
                    xref: termElement.xref?.target)
                terms.append(appTerm)
            }
        } else {
            if let termElement = langElement.termSec as? TermSecElement {
                let appTerm = AppTerm(
                    id: Int(termElement.term.id)!,
                    conceptId: id,
                    subject: descrip._text,
                    lang: langElement.lang,
                    term: termElement.term._text,
                    description: termElement.descrip?._text,
                    xref: termElement.xref?.target)
                terms.append(appTerm)
            }
        }
        return terms
        
    }
}


struct Descrip: Decodable {
    let type: String
    let _text: String
}


struct LangElement: Decodable{
    let termSec: Any
    let lang: String
    
    enum CodingKeys: String, CodingKey {
        case termSec
        case lang  = "xml:lang"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        
        lang = try values.decode(String.self, forKey: .lang)
        
        if let termElement = try? values.decode(TermSecElement.self, forKey: .termSec) {
            termSec = termElement
        } else if let termArray = try? values.decode([TermSecElement].self, forKey: .termSec) {
            termSec = termArray
        } else {
            throw DecodingError.dataCorruptedError(forKey:.termSec, in: values, debugDescription: "Value cannot be decoded!")
        }
    }
    
    
}

// Stub constructor for testing purposes
extension LangElement{
    init() {
        let tbxterm = TBXTerm(id: "555", _text: "psychological operation")
        let descrip = Descrip(type: "context", _text: "Planned activities using methods of communication and other means directed at approved audiences in order to influence perceptions, attitudes and behaviour, affecting the achievement of political and military objectives.")
        let xref = TBXxref(type: "externalCrossReference", target: "https://github.com/pobedria/mildictmeta/blob/main/AAP-06.pdf")
        
        termSec = TermSecElement(term: tbxterm, descrip: descrip, xref: xref)
        lang="en"
        
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
