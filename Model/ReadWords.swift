//
//  ReadWords.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation

class ReadData: ObservableObject  {
    @Published var users = [Term]()
    
        
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let users = try? JSONDecoder().decode([Term].self, from: data!)
        self.users = users!
        
    }
     
}
