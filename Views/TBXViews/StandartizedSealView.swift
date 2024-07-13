//
//  CircleLabelView.swift
//  MilDict
//
//  Created by Viktor Pobedria on 12.07.2024.
//

import SwiftUI

struct StandartizedSealView: View {
    @State private var opacity: Double = 1.0
    var kerning: CGFloat = 10
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
                            .foregroundColor(.green)
                            .kerning(kerning)
                        
                        
                        Spacer()
                    }
                    .rotationEffect(angle(at: index))
                    
                        
                }
                
            }.frame(width: size.width, height: size.height)
                .rotationEffect(-angle(at: texts.count-5))
            Circle()
                .strokeBorder(.green,lineWidth: 3)
                .frame(width: 190, height: 190)
            Circle()
                .strokeBorder(.green,lineWidth: 3)
                .frame(width: 150, height: 150)
            
            Image("ZSU")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)

        }
        .font(.system(size: 13, design: .monospaced))
        .bold()
        .opacity(opacity)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                withAnimation(.linear(duration: 2)) {
//                    opacity = 0.2
//                }
//            }
//        }
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
        
    )
}
