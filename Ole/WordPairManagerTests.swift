//
//  WordPairManagerTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-13.
//

@testable import Ole
import XCTest

class WordPairManagerTests: XCTestCase {

    func testCreation() throws {
        // Act
        let manager = WordPairManager.shared
        let manager2 = WordPairManager.shared

        // Assert
        XCTAssertNotNil(manager)
        XCTAssertTrue(manager === manager2) // singleton
    }

    func testNewWordPair() throws {
        // Arrange
        let parser = ParserMock(translationsList: [Translation(english: "hello", translations: ["hola"])])
        let manager = WordPairManager(parser: parser)

        // Act
        let wordPair = manager.newWordPair()

        // Assert
        XCTAssertEqual(wordPair.english, "hello")
        XCTAssertEqual(wordPair.spanish, "hola")
    }

    func testNewWordPairWithMultipleWords() throws {
        // Arrange
        let list = [Translation(english: "hello", translations: ["hola", "buenos días", "buenos", "aló", "saludos"]),
                    Translation(english: "bye", translations: ["adiós", "chao", "chau"]),
                    Translation(english: "yes", translations: ["sí"]),
                    Translation(english: "no", translations: ["no"]),
                    Translation(english: "thanks", translations: ["gracias"]),
                    Translation(english: "you're welcome", translations: ["de nada", "no hay de qué"])]
        let parser = ParserMock(translationsList: list)
        let manager = WordPairManager(parser: parser)

        // Act
        let wordPair = manager.newWordPair()

        // Assert
        XCTAssertEqual(wordPair.english.isEmpty, false)
        XCTAssertEqual(wordPair.spanish.isEmpty, false)
    }

    func testIsCorrectPair() throws {
        // Arrange
        let parser = ParserMock(translationsList: [Translation(english: "hello", translations: ["hola"])])
        let manager = WordPairManager(parser: parser)
        let wordPair = WordPair(english: "hello", spanish: "hola")

        // Act
        let answer = manager.isCorrectPair(english: wordPair.english, spanish: wordPair.spanish)

        // Assert
        XCTAssertEqual(wordPair.english, "hello")
        XCTAssertEqual(answer, true)
    }

    func testIsCorrectPairFalse() throws {
        // Arrange
        let parser = ParserMock(translationsList: [Translation(english: "hello", translations: ["hola"])])
        let manager = WordPairManager(parser: parser)
        let wordPair = WordPair(english: "hello", spanish: "falso")

        // Act
        let answer = manager.isCorrectPair(english: wordPair.english, spanish: wordPair.spanish)

        // Assert
        XCTAssertEqual(wordPair.english, "hello")
        XCTAssertEqual(answer, false)
    }

    func testIsCorrectPairWithMultipleTranslations() throws {
        // Arrange
        let parser = ParserMock(translationsList: [Translation(english: "hello", translations: ["hola", "buenos días", "buenos", "aló", "saludos"])])
        let manager = WordPairManager(parser: parser)
        let wordPair = manager.newWordPair()

        // Act
        let answer = manager.isCorrectPair(english: wordPair.english, spanish: wordPair.spanish)

        // Assert
        XCTAssertEqual(wordPair.english, "hello")
        XCTAssertEqual(answer, true)
    }

    func testIsCorrectPairWithSpanishSynonyms() throws {
        // Arrange
        let list = [Translation(english: "hello", translations: ["hola", "buenos días", "buenos"]),
                    Translation(english: "good morning", translations: ["buenos días", "buenos", "hola"])]
        let parser = ParserMock(translationsList: list)
        let manager = WordPairManager(parser: parser)
        let wordPair = manager.newWordPair()

        // Act
        let answer = manager.isCorrectPair(english: wordPair.english, spanish: wordPair.spanish)

        // Assert
        XCTAssertEqual(answer, true)
    }

    /**
     Runs the newWordPair function over and over.
     Then counts the total number of correct pairs, and divides by the total number of pairs. This number should be approximately 25%.

     The reason this is approximate and not exactly 25% is because 1. random numbers always have some variation in their probability, and
     2. there are multiple Spanish translations for some English words, which increases the likelihood of a correct translation, which is the case in the words.json file.
     */
    func testNewWordPair25PercentProbability() throws {

        // Arrange
        let list = [Translation(english: "hello", translations: ["hola"]),
                    Translation(english: "bye", translations: ["adiós"]),
                    Translation(english: "yes", translations: ["sí"]),
                    Translation(english: "no", translations: ["no"]),
                    Translation(english: "maybe", translations: ["tal vez"]),
                    Translation(english: "please", translations: ["por favor"]),
                    Translation(english: "thanks", translations: ["gracias"]),
                    Translation(english: "you're welcome", translations: ["de nada", "no hay de qué"]),
                    Translation(english: "sorry", translations: ["lo siento"]),
                    Translation(english: "pardon", translations: ["perdón"]),
                    Translation(english: "okay", translations: ["vale"]),
                    Translation(english: "nice", translations: ["simpático"]),
                    Translation(english: "good", translations: ["bueno"]),
                    Translation(english: "bad", translations: ["malo"]),
                    Translation(english: "trump", translations: ["pendejo"])]
        let parser = ParserMock(translationsList: list)
        let manager = WordPairManager(parser: parser)

        // Act
        let wordPairs: [WordPair] = (1...1000).map { (i) -> WordPair in
            return manager.newWordPair()
        }
        let totalCorrectPairs = wordPairs
            .map {
            manager.isCorrectPair(english: $0.english, spanish: $0.spanish)
            }
            .filter { $0 == true }
            .count

        let percentage = Double(totalCorrectPairs) / Double(wordPairs.count)
        let approximatePercentage = Int(percentage * 100)

        // Assert
        XCTAssertTrue(approximatePercentage >= 20)
        XCTAssertTrue(approximatePercentage <= 30)
    }

}

private struct ParserMock: Parser {
    var translationsList: [Translation]
}
