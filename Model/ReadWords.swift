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
    let terms:[Term] = load("terms.json")
    return terms.sorted(by:{$0.en_title.lowercased()<$1.en_title.lowercased()})
}

func loadAbbreviations() -> [Abbreviation]{
    let abbreviations: [Abbreviation] = load("abbreviation.json")
    return abbreviations
}

