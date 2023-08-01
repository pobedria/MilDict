//
//  extensions.swift
//  MilDict
//
//  Created by Viktor Pobedria on 31.07.2023.
//

import Foundation

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
        let upper = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЮЯ"
        let lower = "абвгдежзийклмнопрстуфхцчшщьюя"

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
