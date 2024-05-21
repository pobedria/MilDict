//
//  QuizUIView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 21.05.2024.
//

import SwiftUI

struct QuizTabView: View {
    @State private var concepts = TermsSorage.allConcepts.choose(4)
    @State private var correctNumber: Int = Int.random(in: 0..<4)
    @State private var selection: String?
    
    var body: some View {

        let options = concepts.enumerated().map { offset, element in
            QuizOption(
                name: element.ukTermsOfConcept().first!.term,
                isCorrect: offset == correctNumber
            )
        }
        VStack {
            Text(concepts[correctNumber].enTermsOfConcept().first!.term)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .foregroundColor(Color("Gold"))
                .background(Color("Olive"))
            if let selection {
                if options.filter({ $0.name == selection }).first!.isCorrect{
                    Text ("Вірно")
                        .foregroundColor(.green)
                        .font(Font.custom("UAFSans-Medium", size: 30))
                } else {
                    Text ("Правильна відповідь:\n\(options[correctNumber].name)")
                        .foregroundColor(.red)
                        .font(Font.custom("UAFSans-Medium", size: 30))
                }
                
            }
            List(options, id: \.name) { option in
                Button(option.name){
                    selection = option.name 
                    withAnimation(.easeInOut(duration: 5)) {
                        correctNumber = Int.random(in: 0..<4)
                        selection = nil
                        concepts = TermsSorage.allConcepts.choose(4)
                    }
                }
                
            }.scrollContentBackground(.hidden)

        }
        .padding(.bottom)
        .padding(.bottom)
        .padding(.bottom)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("Olive"))
        .font(Font.custom("UAFSans-Medium", size: 20))
        
    }
}

#Preview {
    QuizTabView()
}
