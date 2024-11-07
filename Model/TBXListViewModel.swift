//
//  TBXListViewModel.swift
//  MilDict
//
//  Created by Viktor Pobedria on 07.11.2024.
//

import SwiftUI
import Combine


class TBXListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [AppTerm] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    let lang: String
    
    init(lang: String) {
        self.lang = lang
        setupSearchPublisher()
    }
    
    private func setupSearchPublisher() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .map { [weak self] (searchText) -> [AppTerm] in
                guard let self = self else { return [] }
                return self.performSearch(with: searchText)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] results in
                self?.searchResults = results
            }
            .store(in: &cancellables)
    }
    
    func levenshteinDistance(_ s1: String, _ s2: String) -> Int {
        let s1 = Array(s1)
        let s2 = Array(s2)
        var dist = [[Int]](repeating: [Int](repeating: 0, count: s2.count + 1), count: s1.count + 1)

        for i in 0...s1.count {
            dist[i][0] = i
        }

        for j in 0...s2.count {
            dist[0][j] = j
        }

        for i in 1...s1.count {
            for j in 1...s2.count {
                if s1[i - 1] == s2[j - 1] {
                    dist[i][j] = dist[i - 1][j - 1]
                } else {
                    dist[i][j] = min(
                        dist[i - 1][j] + 1,
                        dist[i][j - 1] + 1,
                        dist[i - 1][j - 1] + 1
                    )
                }
            }
        }

        return dist[s1.count][s2.count]
    }

    func levenshteinDistanceBetweenWordSequences(_ seq1: [String], _ seq2: [String]) -> Int {
        let m = seq1.count
        let n = seq2.count
        var dist = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)

        for i in 0...m {
            dist[i][0] = i
        }

        for j in 0...n {
            dist[0][j] = j
        }

        for i in 1...m {
            for j in 1...n {
                if seq1[i - 1] == seq2[j - 1] {
                    dist[i][j] = dist[i - 1][j - 1]
                } else {
                    dist[i][j] = min(
                        dist[i - 1][j] + 1,
                        dist[i][j - 1] + 1,
                        dist[i - 1][j - 1] + 1
                    )
                }
            }
        }

        return dist[m][n]
    }

    func totalMinimumLevenshteinDistanceUnordered(searchWords: [String], termWords: [String]) -> Int {
        var totalDistance = 0

        for searchWord in searchWords {
            let distances = termWords.map { termWord in
                let truncatedTermWord = String(termWord.prefix(searchWord.count))
                return levenshteinDistance(searchWord, truncatedTermWord)
            }
            if let minDistance = distances.min() {
                totalDistance += minDistance
            } else {
                totalDistance += searchWord.count
            }
        }

        return totalDistance
    }

    func performSearch(with searchText: String) -> [AppTerm] {
        if searchText.isEmpty {
            return lang == "en" ? TermsStorage.enTerms : TermsStorage.ukTerms
        } else {
            let sanitizedField = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            let searchWords = sanitizedField.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
            guard !searchWords.isEmpty else {
                return lang == "en" ? TermsStorage.enTerms : TermsStorage.ukTerms
            }

            let totalSearchLength = searchWords.reduce(0) { $0 + $1.count }
            let maximumTotalDistance = Int(Double(totalSearchLength) * 0.5) // Налаштуйте відсоток за потреби

            let results = TermsStorage.allTerms
                .map { term -> (AppTerm, Int, Int) in
                    let termLowercased = term.term.lowercased()
                    let termWords = termLowercased.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }

                    let letterDistance = totalMinimumLevenshteinDistanceUnordered(searchWords: searchWords, termWords: termWords)
                    let wordSequenceDistance = levenshteinDistanceBetweenWordSequences(searchWords, termWords)

                    return (term, letterDistance, wordSequenceDistance)
                }
                .filter { $0.1 <= maximumTotalDistance }
                .sorted {
                    if $0.2 != $1.2 {
                        return $0.2 < $1.2
                    } else {
                        return $0.1 < $1.1
                    }
                }
                .map { $0.0 }

            return results
        }
    }
}
