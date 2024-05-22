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
    @State private var selection: Int?
    @State private var blockedButtons = false
    
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
                if selection == correctNumber{
                    Text ("Вірно")
                        .foregroundColor(.green)
                        .font(Font.custom("UAFSans-Bold", size: 30))
                } else {
                    Text ("Правильна відповідь:\n\(options[correctNumber].name)")
                        .foregroundColor(.red)
                        .font(Font.custom("UAFSans-Medium", size: 30))
                }
                
            }
            ForEach(Array(zip(options.indices, options)), id: \.0) { index, option in
                Button(option.name){
                    if !blockedButtons {
                        blockedButtons = true
                        selection = index
                        Task {
                            await delayPageUpdate()
                        }
                    }
                    
                }.frame(maxWidth: .infinity)
                .padding()
                .background(Color("Steppe"))
                .clipShape(Capsule())
                
            }.scrollContentBackground(.hidden)
                .padding(.horizontal)
            

        }
        .padding(.bottom)
        .padding(.bottom)
        .padding(.bottom)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("Olive"))
        .font(Font.custom("UAFSans-Medium", size: 20))
        
    }
    private func delayPageUpdate() async {
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
        sleep(2)
        withAnimation(){
            print("Block false")
            blockedButtons = false
            correctNumber = Int.random(in: 0..<4)
            selection = nil
            concepts = TermsSorage.allConcepts.choose(4)
        }
        
        
    }
}

#Preview {
    QuizTabView()
}
