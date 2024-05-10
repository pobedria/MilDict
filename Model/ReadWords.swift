//
//  ReadWords.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else { fatalError("Couldn't find \(filename) in main bundle.") }

    do {
        data = try Data(contentsOf: file)
    } catch { fatalError("Couldn't load \(filename) from main bundle:\n\(error)") }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch { fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)") }
}

func loadSortedTerms() -> [Term]{
    loadAppTerms()
    let terms:[Term] = load("terms.json")
    let lovercasedTerms = terms.map{
        Term(
            id: $0.id,
            en_title: $0.en_title.lowercased(),
            en_text: $0.en_text,
            ua_title: $0.ua_title.lowercased(),
            ua_text: $0.ua_text
        )
    }
    return lovercasedTerms.sorted(by:{$0.en_title.compareDigitsInTheEnd($1.en_title)})
}

func loadAbbreviations() -> [Abbreviation]{
    let abbreviations: [Abbreviation] = load("abbreviations.json")
    return abbreviations
}

func loadAppTerms() -> [AppTerm]{
    let concepts = decodeConcepts()
    
    return transformConceptsToTerms(concepts)
}

func decodeConcepts() -> [TBXConcept]{
    
    var concepts:[TBXConcept] = []
    
    concepts.append(contentsOf: load("J-1 – питання персоналу.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-2 – розвідка.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-3 – оперативна діяльність.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-4 – логістика.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-5 – оборонне планування.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-6 – зв’язок та інформаційні системи.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-7 – підготовка військ.json") as [TBXConcept])
    concepts.append(contentsOf: load("J-9 – цивільно-військове співробітництво.json") as [TBXConcept])

    return concepts
}

func transformConceptsToTerms(_ concepts:[TBXConcept]) -> [AppTerm]{
    
    var terms = [AppTerm]()
    for concept in concepts {
        for langElement in concept.langSec{
            if let termArray = langElement.termSec as? [TermSecElement] {
                for termElement in termArray{
                    let appTerm = AppTerm(
                        id: Int(termElement.term.id)!,
                        conceptId: Int(concept.id)!,
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
                        conceptId: Int(concept.id)!,
                        lang: langElement.lang,
                        term: termElement.term._text,
                        description: termElement.descrip?._text,
                        xref: termElement.xref?.target)
                    terms.append(appTerm)
                }
            }
        }
        
    }
    print(terms)
    return terms
}
