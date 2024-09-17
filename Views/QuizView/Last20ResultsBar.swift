//
//  Last20ResultsBar.swift
//  MilDict
//
//  Created by Viktor Pobedria on 17.09.2024.
//

import SwiftUI

struct Last20ResultsBar: View {
    let progress: Int // Значення від 0 до 20
    let feedbackText: String?
    let feedbackColor: Color?

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width

            if let feedbackText = feedbackText, let feedbackColor = feedbackColor {
                // Відображаємо повний бар з кольором зворотного зв'язку та текстом
                ZStack {
                    Rectangle()
                        .fill(feedbackColor)
                        .frame(width: totalWidth, height: 20)
                        .cornerRadius(10)
                    Text(feedbackText)
                        .foregroundColor(.white)
                        .bold()
                }
            } else {
                // Відображаємо звичайний прогрес-бар
                let progressWidth = CGFloat(progress) / 20 * totalWidth
                let remainingWidth = totalWidth - progressWidth

                ZStack {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: progressWidth)
                        Rectangle()
                            .fill(Color.steppe)
                            .frame(width: remainingWidth)
                    }
                    .frame(width: totalWidth, height: 20)
                    .cornerRadius(10)

                    Text("\(progress)/20")
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .frame(height: 20)
        .animation(.linear(duration: 0.2), value: progress)
    }
}



