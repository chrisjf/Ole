//
//  WordPairManager.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import Foundation
import os

protocol PairManager {
    func newWordPair() -> WordPair
    func isCorrectPair(english: String, spanish: String) -> Bool
    func isCorrectPair(_ wordPair: WordPair) -> Bool
}

/**
 Responsible for choosing word pairs to display from the (English-Spanish) translation bank and the (Spanish) word
 bank, as well as to say what is the correct answer
 */
class WordPairManager: PairManager {

    private let translationBank: [Translation]
    private let wordBank: [String]

    static let shared = WordPairManager(parser: TranslationsParser(resouceName: TranslationsParserConstants.dataFile)) // singleton

    init(parser: Parser) {
        // Add translations from JSON file to translation bank
        translationBank = parser.translationsList

        // Add all words to word bank
        let allWords = parser.translationsList.flatMap {
            $0.translations
        }
        wordBank = allWords
    }

    func newWordPair() -> WordPair {
        guard let current = translationBank.randomElement() else {
            fatalError()
        }

        // Probability for a correct word pair should be 25%
        let possibleParings = [current.translations.randomElement(),
                               wordBank.randomElement(),
                               wordBank.randomElement(),
                               wordBank.randomElement()].compactMap { $0 }

        guard let spanish = possibleParings.randomElement() else {
            fatalError()
        }

        return WordPair(english: current.english, spanish: spanish)
    }

    func isCorrectPair(english: String, spanish: String) -> Bool {
        guard let translation = translationBank.filter({ $0.english.contains(english) }).first else {
            os_log("English word was not found in the list of english words", type: .error)
            return false
        }
        return translation.translations.contains(spanish)
    }

    // Convenience method
    func isCorrectPair(_ wordPair: WordPair) -> Bool {
        return isCorrectPair(english: wordPair.english, spanish: wordPair.spanish)
    }

}
