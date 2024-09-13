//
//  QuizUIView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 21.05.2024.
//

import SwiftUI

struct QuizTabView: View {
    @State private var concepts = TermsStorage.allConcepts.choose(4)
    @State private var correctNumber: Int = Int.random(in: 0..<4)
    @State private var selection: Int?
    @State private var blockedButtons = false
    @State private var buttonBackgrounds = Array(repeating: Color("Steppe"), count: 4)
    
    
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
                if let selection = selection {
                    Text(selection == correctNumber ? "Правильно" : "Неправильно")
                        .foregroundColor(selection == correctNumber ? .green : .red)
                        .font(Font.custom("UAFSans-Bold", size: 25))
                        .padding()
                }
                ForEach(Array(zip(options.indices, options)), id: \.0) { index, option in
                    Button(action:{
                        if !blockedButtons {
                            blockedButtons = true
                            selection = index
                            buttonBackgrounds[index] = .red
                            buttonBackgrounds[correctNumber] = .green
                            if selection == correctNumber {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            } else {
                                UINotificationFeedbackGenerator().notificationOccurred(.error)
                            }
                            Task {
                                await delayPageUpdate()
                            }
                        }
                        
                    }){
                        Text(option.name)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(buttonBackgrounds[index])
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
            concepts = TermsStorage.allConcepts.choose(4)
            buttonBackgrounds = Array(repeating: Color("Steppe"), count: 4)
        }
    }
}

#Preview {
    QuizTabView()
}
