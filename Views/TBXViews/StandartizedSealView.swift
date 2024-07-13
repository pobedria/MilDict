//
//  CircleLabelView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 12.07.2024.
//

import SwiftUI

struct StandartizedSealView: View {
    var kerning: CGFloat = 30
    var size: CGSize = .init(width: 150, height: 150)
    var radius: Double
    var text: String
    var texts: [(offset: Int, element: Character)] {
        return Array(text.enumerated())
    }
    
    @State var textWidths: [Int:Double] = [:]
    
    
    
    var body: some View {
        ZStack {
            ForEach(texts, id: \.offset) { index, letter in
                VStack {
                    Text(String(letter))
                        .background(Sizeable())
                        .onPreferenceChange(WidthPreferenceKey.self, perform: { width in
                            textWidths[index] = width
                        }).kerning(kerning)
                    Spacer()
                }.rotationEffect(angle(at: index))
            }
        }.frame(width: size.width, height: size.height)
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

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: Double = 0
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct Sizeable: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

#Preview {
    StandartizedSealView(
        radius: 150,
        text: "Стандартизований термін".uppercased()
    ).font(.system(size: 13, design: .monospaced)).bold()
}
