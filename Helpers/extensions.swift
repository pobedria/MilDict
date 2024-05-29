//
//  extensions.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation
import SwiftUI

extension String {
    var isLatin: Bool {
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower = "abcdefghijklmnopqrstuvwxyz"

        for c in self.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }

        return true
    }

    var isCyrillic: Bool {
        let upper = "АБВГҐДЕЖЗИЙІЇКЛМНОПРСТУФХЦЧШЩЬЮЯ"
        let lower = "абвгґдежзийіїклмнопрстуфхцчшщьюя"

        for c in self.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }

        return true
    }

    var isBothLatinAndCyrillic: Bool {
        return self.isLatin && self.isCyrillic
    }
}

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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension String {
    func compareDigitsInTheEnd(_ other: String) -> Bool{
        if let leftChar = self.first, let rightChar = other.first {
            if !leftChar.isLetter && rightChar.isLetter {
                return false
            } else if leftChar.isLetter && !rightChar.isLetter {
                return true
            } else {
                return self < other
            }
        } else {
            return self < other
        }
    }
}


extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}


extension View {
    func navigationBarColor(_ color: UIColor) -> some View {
        self.modifier(NavigationBarColorModifier(color: color))
    }
}

struct NavigationBarColorModifier: ViewModifier {
    var color: UIColor

    func body(content: Content) -> some View {
        content
            .onAppear {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.configureWithOpaqueBackground()
                coloredAppearance.backgroundColor = color

                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().compactAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}
