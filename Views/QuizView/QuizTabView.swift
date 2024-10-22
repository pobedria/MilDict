import SwiftUI
import AVFoundation

struct QuizTabView: View {
    // MARK: - Properties
    @State private var concepts: [TBXConcept] = []
    @State private var questionSubject: String = ""
    @State private var correctNumber: Int = 0
    @State private var selection: Int? = nil
    @State private var isButtonsDisabled = false
    @State private var synthesizer = AVSpeechSynthesizer()
    @State private var isMuted: Bool = false
    @State private var currentProgress: Int = 0 // Змінна для прогресу (від 0 до 20)
    @State private var showAlert = false // Стан для відображення алерту
    @State private var isLandscape: Bool = false // Стан для орієнтації

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            VStack {
                HStack{
                    Spacer()
                    Button(action: {
                        isMuted.toggle()
                        if isMuted {
                           if synthesizer.isSpeaking {
                               synthesizer.stopSpeaking(at: .immediate)
                           }
                        } else {
                           if let question = questionTerm {
                               speak(text: question)
                           }
                       }
                    }) {
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gold)
                            
                    }
                    .accessibilityLabel(isMuted ? "Звук вимкнено" : "Звук увімкнено")
                }.padding([.top, .trailing])
                // Відображення прогрес-бару з повідомленням зворотного зв'язку
                Last20ResultsBar(progress: currentProgress, feedbackText: feedbackText, feedbackColor: feedbackColor)
                    .frame(height: 20)
                    .padding()
                if let question = questionTerm {
                    Text(question)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gold)
                        .background(Color.olive)
                        .onTapGesture {
                            speak(text: question)
                        }
                } else {
                    Text("Завантаження...")
                        .foregroundColor(.gray)
                }
                Text(questionSubject)
                    .foregroundColor(.steppe)
                    .font(Font.custom("UAFSans-Medium", size: 12))

                Spacer()

                // Видаляємо окремий Text з повідомленням зворотного зв'язку

                if isLandscape {
                    // Горизонтальна орієнтація: кнопки в сітці 2x2
                    let columns = [GridItem(.flexible()), GridItem(.flexible())]
                    LazyVGrid(columns: columns, spacing: 16) {
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
                        }
                    }
                    .padding(.horizontal)
                } else {
                    // Вертикальна орієнтація: кнопки в одній колонці
                    VStack {
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
                }
            }
            .padding(.bottom, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.olive)
            .font(Font.custom("UAFSans-Medium", size: 20))
            .onAppear {
                self.isLandscape = isLandscape
                setupNewQuestion()
            }
            .onChange(of: isLandscape) { newValue in
                self.isLandscape = newValue
            }
            // Додаємо алерт
            .alert("Вітаємо! 🥳", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    resetProgress()
                }
            } message: {
                Text("Ви успішно відповіли на 20 питань! Продовжуйте в тому ж дусі.")
            }
        }
    }

    // MARK: - Computed Properties
    private var feedbackText: String? {
        guard let selection = selection else { return nil }
        return selection == correctNumber ? "Правильно" : "Неправильно"
    }

    private var feedbackColor: Color? {
        guard let selection = selection else { return nil }
        return selection == correctNumber ? .green : .red
    }

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

    // MARK: - Methods
    private func handleSelection(at index: Int) {
        guard !isButtonsDisabled else { return }
        selection = index
        isButtonsDisabled = true

        let isCorrect = (index == correctNumber)
        if isCorrect {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            currentProgress += 1
            if currentProgress >= 20 {
                currentProgress = 20
                showAlert = true // Відображаємо алерт
            }
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            currentProgress -= 1
            if currentProgress < 0 {
                currentProgress = 0
            }
        }

        // Затримка перед наступним питанням
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 секунди
            withAnimation {
                setupNewQuestion()
            }
        }
    }

    private func resetProgress() {
        currentProgress = 0
    }

    private func setupNewQuestion() {
        guard !showAlert else { return } // Запобігаємо появі нового питання під час алерту
        isButtonsDisabled = false
        selection = nil

        // Обираємо випадковий концепт як правильну відповідь
        guard let correctConcept = TermsStorage.allConcepts.randomElement() else {
            return
        }
        questionSubject = correctConcept.descrip._text

        // Отримуємо всі концепти з тим самим descrip._text, виключаючи правильний концепт
        let sameSubjectConcepts = TermsStorage.allConcepts.filter { $0.descrip._text == questionSubject && $0.id != correctConcept.id }

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

        // Озвучуємо питання
        if let question = questionTerm {
            speak(text: question)
        }
    }

    private func speak(text: String) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        guard !isMuted else { return }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
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
