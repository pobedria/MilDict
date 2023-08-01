//
//  ReadWords.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation

class ReadData: ObservableObject  {
    @Published var terms = [Term]()
    
        
    init(){
        self.terms = loadSortedTerms()
    }
    
    func loadTerms() -> [Term]  {
        guard let url = Bundle.main.url(forResource: "terms", withExtension: "json")
            else {
                print("Json file not found")
                return []
            }
        
        let data = try? Data(contentsOf: url)
        return try! JSONDecoder().decode([Term].self, from: data!)
    }
    
    func loadSortedTerms() -> [Term]{
        let words = loadTerms()
        return words.sorted(by:{$0.en_title.lowercased()<$1.en_title.lowercased()})
    }
}
