//
//  GameplayControllerTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-13.
//

@testable import Ole
import XCTest

class GameplayControllerTests: XCTestCase {

    private var controller: GameplayController!
    private var manager: WordPairManagerMock!
    private let wordPair1 = WordPair(english: "hello", spanish: "hola")
    private let wordPair2 = WordPair(english: "bye", spanish: "adiós")

    override func setUpWithError() throws {
        manager = WordPairManagerMock()
        manager.pairs = [wordPair1, wordPair2]
        controller = GameplayController(wordPairManager: manager)
    }

    func testCreation() throws {
        // Act
        let controller = GameplayController()

        // Assert
        XCTAssertNotNil(controller)
        XCTAssertNotNil(controller.currentWordPair)
        XCTAssertNotNil(controller.scoreboard)
        XCTAssertNotNil(controller.gameplayTimerSubscription)
    }

    func testStartGameplay() throws {
        // Arrange
        let firstSubscription = controller.gameplayTimerSubscription

        // Act
        controller.startGameplay()

        // Assert
        XCTAssertEqual(controller.scoreboard.gameState, .inProgress)
        XCTAssertNotEqual(controller.gameplayTimerSubscription, firstSubscription)
    }

    func testStopGameplay() throws {
        // Arrange
        XCTAssertNotNil(controller.gameplayTimerSubscription)

        // Act
        controller.stopGameplay()

        // Assert
        XCTAssertNil(controller.gameplayTimerSubscription)
    }

    func testResetGameplay() throws {
        // Arrange
        (1...2).forEach { _ in controller.scoreboard.gainedPoint() }
        (1...2).forEach { _ in controller.scoreboard.lostPoint() }
        let oldPair = controller.currentWordPair

        // Act
        controller.resetGameplay()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 0)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(controller.scoreboard.gameState, .none)
        XCTAssertNotEqual(controller.currentWordPair, oldPair)
    }

    func testTappedCorrectForCurrentWordPairAndUserAnsweredCorrectly() throws {
        // Arrange
        manager.isCorrect = true
        XCTAssertEqual(wordPair1, controller.currentWordPair)

        // Act
        controller.tappedCorrectForCurrentWordPair()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 1)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 0)
        XCTAssertNotEqual(wordPair1, controller.currentWordPair)
    }

    func testTappedCorrectForCurrentWordPairAndUserAnsweredIncorrectly() throws {
        // Arrange
        manager.isCorrect = false
        XCTAssertEqual(wordPair1, controller.currentWordPair)

        // Act
        controller.tappedCorrectForCurrentWordPair()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 0)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 1)
        XCTAssertNotEqual(wordPair1, controller.currentWordPair)
    }

    func testTappedIncorrectForCurrentWordPairAndUserAnsweredCorrectly() throws {
        // Arrange
        manager.isCorrect = false
        XCTAssertEqual(wordPair1, controller.currentWordPair)

        // Act
        controller.tappedIncorrectForCurrentWordPair()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 1)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 0)
        XCTAssertNotEqual(wordPair1, controller.currentWordPair)
    }

    func testTappedIncorrectForCurrentWordPairAndUserAnsweredIncorrectly() throws {
        // Arrange
        manager.isCorrect = true
        XCTAssertEqual(wordPair1, controller.currentWordPair)

        // Act
        controller.tappedIncorrectForCurrentWordPair()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 0)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 1)
        XCTAssertNotEqual(wordPair1, controller.currentWordPair)
    }

    func testResetTimer() throws {
        // Act
        controller.resetTimer()

        // Assert
        XCTAssertNotNil(controller.gameplayTimerSubscription)
    }

    func testTimeRanOut() throws {
        // Arrange
        XCTAssertEqual(wordPair1, controller.currentWordPair)

        // Act
        controller.timeRanOut()

        // Assert
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 1)
        XCTAssertNotEqual(wordPair1, controller.currentWordPair)
    }

}

private class WordPairManagerMock: PairManager {

    var pairs: [WordPair] = []
    var isCorrect: Bool = false

    private var counter = 0

    func newWordPair() -> WordPair {
        let pair = pairs[counter]
        counter += 1
        return pair
    }

    func isCorrectPair(english: String, spanish: String) -> Bool {
        return isCorrect
    }

    func isCorrectPair(_ wordPair: WordPair) -> Bool {
        return isCorrect
    }

}
