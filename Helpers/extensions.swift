//
//  extensions.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation
import SwiftUI

//extension String {
//    var isLatin: Bool {
//        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//        let lower = "abcdefghijklmnopqrstuvwxyz"
//
//        for c in self.map({ String($0) }) {
//            if !upper.contains(c) && !lower.contains(c) {
//                return false
//            }
//        }
//
//        return true
//    }
//
//    var isCyrillic: Bool {
//        let upper = "АБВГҐДЕЖЗИЙІЇКЛМНОПРСТУФХЦЧШЩЬЮЯ"
//        let lower = "абвгґдежзийіїклмнопрстуфхцчшщьюя"
//
//        for c in self.map({ String($0) }) {
//            if !upper.contains(c) && !lower.contains(c) {
//                return false
//            }
//        }
//
//        return true
//    }
//
//    var isBothLatinAndCyrillic: Bool {
//        return self.isLatin && self.isCyrillic
//    }
//}

extension Sequence {
    public func filter(where isIncluded: (Iterator.Element) -> Bool, limit: Int) -> [Iterator.Element] {
        var result : [Iterator.Element] = []
        result.reserveCapacity(limit)
        var count = 0
        var it = makeIterator()

        // While limit not reached and there are more elements ...
        while count < limit, let element = it.next() {
            if isIncluded(element) {
                result.append(element)
                count += 1
            }
        }
        return result
    }
}

//extension View {
//    func placeholder<Content: View>(
//        when shouldShow: Bool,
//        alignment: Alignment = .leading,
//        @ViewBuilder placeholder: () -> Content) -> some View {
//
//        ZStack(alignment: alignment) {
//            placeholder().opacity(shouldShow ? 1 : 0)
//            self
//        }
//    }
//}

//extension String {
//    func compareDigitsInTheEnd(_ other: String) -> Bool{
//        if let leftChar = self.first, let rightChar = other.first {
//            if !leftChar.isLetter && rightChar.isLetter {
//                return false
//            } else if leftChar.isLetter && !rightChar.isLetter {
//                return true
//            } else {
//                return self < other
//            }
//        } else {
//            return self < other
//        }
//    }
//}


extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}


struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?
    

    init(backgroundColor: Color, titleColor: UIColor?) {
        self.backgroundColor = UIColor(backgroundColor)
        
        let inlineTitleFont = UIFont(name: "UAFSans-OnBoardStencil", size: 15)
        let largeTitleFont = UIFont(name: "UAFSans-OnBoardStencil", size: 28)
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = self.backgroundColor // The key is here. Change the actual bar to clear.
        standardAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white, .font:  inlineTitleFont!]
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white, .font:  largeTitleFont!]
//        standardAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.configureWithTransparentBackground()
        compactAppearance.backgroundColor = .clear // The key is here. Change the actual bar to clear.
        compactAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white, .font:  inlineTitleFont!]
        compactAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white, .font:  largeTitleFont!]
//        compactAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().compactAppearance = compactAppearance
        
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.backgroundColor = .clear // The key is here. Change the actual bar to clear.
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white, .font:  inlineTitleFont!]
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white, .font:  largeTitleFont!]
//        scrollEdgeAppearance.shadowColor = .clear
        
        
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func navigationBarColor(backgroundColor: Color, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}

extension Color {
    static let gold = Color("Gold")
    static let olive = Color("Olive")
    static let steppe = Color("Steppe")
}
