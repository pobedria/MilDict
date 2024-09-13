//
//  QuizUIView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 21.05.2024.
//

import SwiftUI

struct QuizTabView: View {
    // MARK: - Properties
    @State private var concepts: [TBXConcept] = []
    @State private var correctNumber: Int = 0
    @State private var selection: Int?
    @State private var isButtonsDisabled = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let question = questionTerm {
                Text(question)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.gold)
                    .background(Color.olive)
                    .padding(.top, 60)
            } else {
                Text("Завантаження...")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if let selection = selection {
                Text(selection == correctNumber ? "Правильно" : "Неправильно")
                    .foregroundColor(selection == correctNumber ? .green : .red)
                    .font(Font.custom("UAFSans-Bold", size: 25))
                    .padding()
            }
            
            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    handleSelection(at: index)
                }) {
                    Text(options[index])
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonColor(for: index))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .disabled(isButtonsDisabled)
                .padding(.horizontal)
            }
        
        }
        .padding(.bottom, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.olive)
        .font(Font.custom("UAFSans-Medium", size: 20))
        .onAppear {
            setupNewQuestion()
        }
    }
    
    // MARK: - Methods
    private func handleSelection(at index: Int) {
        guard !isButtonsDisabled else { return }
        selection = index
        isButtonsDisabled = true
        
        if index == correctNumber {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
        
        // Затримка перед наступним питанням
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 секунди
            withAnimation {
                setupNewQuestion()
            }
        }
    }
    
    private func setupNewQuestion() {
            isButtonsDisabled = false
            selection = nil
            
            // Обираємо випадковий концепт як правильну відповідь
            guard let correctConcept = TermsStorage.allConcepts.randomElement() else {
                return
            }
            
            // Отримуємо всі концепти з тим самим descrip._text, виключаючи правильний концепт
            let sameSubjectConcepts = TermsStorage.allConcepts.filter { $0.descrip._text == correctConcept.descrip._text && $0.id != correctConcept.id }
            
            // Якщо концептів з тим самим subject менше ніж 3, доповнюємо іншими випадковими концептами
            var otherConcepts = sameSubjectConcepts.shuffled()
            if otherConcepts.count < 3 {
                let remaining = 3 - otherConcepts.count
                let otherRandomConcepts = TermsStorage.allConcepts.filter { $0.descrip._text != correctConcept.descrip._text && $0.id != correctConcept.id }.shuffled().prefix(remaining)
                otherConcepts.append(contentsOf: otherRandomConcepts)
            } else {
                otherConcepts = Array(otherConcepts.prefix(3))
            }
            
            // Формуємо масив концептів для поточного питання
            concepts = [correctConcept] + otherConcepts
            concepts.shuffle() // Перемішуємо, щоб правильна відповідь була на випадковій позиції
            correctNumber = concepts.firstIndex(where: { $0.id == correctConcept.id }) ?? 0
        }
    
    // MARK: - Computed Properties
    private var questionTerm: String? {
        guard concepts.indices.contains(correctNumber),
              let term = concepts[correctNumber].enTermsOfConcept().first?.term else {
            return nil
        }
        return term
    }
    
    private var options: [String] {
        concepts.compactMap { concept in
            concept.ukTermsOfConcept().first?.term
        }
    }
    
    private func buttonColor(for index: Int) -> Color {
        if let selection = selection {
            if index == correctNumber {
                return .green
            } else if index == selection {
                return .red
            }
        }
        return Color("Steppe")
    }
}

#Preview {
    QuizTabView()
}
