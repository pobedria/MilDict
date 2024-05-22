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
    @State private var buttonBackgrouns = Array(repeating: Color("Steppe"), count: 4)
    
    
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
                .padding(.top).padding(.top).padding(.top)
            
            VStack {
                Spacer()
                if let selection {
                    if selection == correctNumber{
                        Text ("Вірно")
                            .foregroundColor(.green)
                            .font(Font.custom("UAFSans-Bold", size: 30))
                    } else {
                        VStack {
                            Text ("Не вірно")
                                .foregroundColor(.red)
                                .font(Font.custom("UAFSans-Medium", size: 30))
//                            Text ("\(options[correctNumber].name)")
//                                .foregroundColor(.green)
//                                .font(Font.custom("UAFSans-Medium", size: 20))
                        }
                    }
                }
                ForEach(Array(zip(options.indices, options)), id: \.0) { index, option in
                    Button(action:{
                        if !blockedButtons {
                            blockedButtons = true
                            selection = index
                            buttonBackgrouns[index] = .red
                            buttonBackgrouns[correctNumber] = .green
                            
                            Task {
                                await delayPageUpdate()
                            }
                        }
                        
                    }){
                        Text(option.name)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgrouns[index])
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                }
                .padding(.horizontal)
            }
            

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
            buttonBackgrouns = Array(repeating: Color("Steppe"), count: 4)
        }
        
        
    }
}

#Preview {
    QuizTabView()
}
