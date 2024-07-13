//
//  RecomendedSealView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 12.07.2024.
//

import SwiftUI

struct RecommendedSealView: View {
    var kerning: CGFloat = 30
    var size: CGSize = .init(width: 180, height: 180)
    var radius: Double = 150
    var text: String = "Стандартизований термін".uppercased()
    var texts: [(offset: Int, element: Character)] {
        return Array(text.enumerated())
    }
    
    @State var textWidths: [Int:Double] = [:]
    
    
    
    var body: some View {
        ZStack{
            ZStack {
                ForEach(texts, id: \.offset) { index, letter in
                    VStack {
                        Text(String(letter))
                            .background(Sizeable())
                            .onPreferenceChange(WidthPreferenceKey.self, perform: { width in
                                textWidths[index] = width
                            })
                            .foregroundColor(.cyan)
                            .kerning(kerning)
                        
                        
                        Spacer()
                    }.rotationEffect(angle(at: index))
                }
                
            }.frame(width: size.width, height: size.height)
            Circle()
                .strokeBorder(.cyan, lineWidth: 4)
                .frame(width: 200, height: 200)
            Circle()
                .strokeBorder(.cyan, lineWidth: 4)
                .frame(width: 150, height: 150)
            Image(systemName: "hand.thumbsup.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.cyan)

        }.font(.system(size: 13, design: .monospaced)).bold()
    }
    
    func angle(at index: Int) -> Angle {
        guard let labelWidth = textWidths[index] else { return .radians(0) }

        let circumference = radius * 2 * .pi

        let percent = labelWidth / circumference
        let labelAngle = percent * 2 * .pi

        let widthBeforeLabel = textWidths.filter{$0.key < index}.map{$0.value}.reduce(0, +)
        let percentBeforeLabel = widthBeforeLabel / circumference
        let angleBeforeLabel = percentBeforeLabel * 2 * .pi

        return .radians(angleBeforeLabel + labelAngle)
    }
}

#Preview {
    RecommendedSealView()
}
