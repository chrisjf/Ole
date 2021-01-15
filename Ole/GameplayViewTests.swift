//
//  GameplayViewTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-14.
//

@testable import Ole
//import SwiftUI
import XCTest

class GameplayViewTests: XCTestCase {

    var view: GameplayView!
    var controller: GameplayController!
    fileprivate var wordPairMock: WordPairManagerMock!

    override func setUpWithError() throws {
        wordPairMock = WordPairManagerMock()
        controller = GameplayController(wordPairManager: wordPairMock)
        view = GameplayView(isMenuShown: .constant(false))
        view.gameplayController = controller
    }

    func testCreation() throws {
        // Act
        let view = GameplayView(isMenuShown: .constant(false))

        // Assert
        XCTAssertNotNil(view)
    }

    func testDidTapCorrect() throws {
        // Arrange
        XCTAssertEqual(controller.scoreboard.correctAttempts, 0)
        XCTAssertEqual(controller.currentWordPair, wordPairMock.pairs.first!)

        // Act
        view.didTapCorrect()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 1)
        XCTAssertEqual(controller.currentWordPair, wordPairMock.pairs.last!)
    }

    func testDidTapIncorrect() throws {
        // Arrange
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(controller.currentWordPair, wordPairMock.pairs.first!)

        // Act
        view.didTapIncorrect()

        // Assert
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 1)
        XCTAssertEqual(controller.currentWordPair, wordPairMock.pairs.last!)
    }

    func testDidTapQuit() throws {
        // Arrange
        var isMenuShown = false
        view = GameplayView(isMenuShown: .init(get: { isMenuShown }, set: { isMenuShown = $0 }))
        view.gameplayController = controller

        (1...2).forEach { _ in controller.scoreboard.gainedPoint() }
        (1...2).forEach { _ in controller.scoreboard.lostPoint() }
        XCTAssertNotNil(controller.gameplayTimerSubscription)

        // Act
        view.didTapQuit()

        // Assert
        XCTAssertNil(controller.gameplayTimerSubscription)
        XCTAssertEqual(controller.scoreboard.correctAttempts, 0)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(controller.scoreboard.gameState, .none)
        XCTAssertNil(controller.gameplayTimerSubscription)
        XCTAssertEqual(controller.currentWordPair, wordPairMock.pairs.last!)
        XCTAssertTrue(isMenuShown)
    }

    func testDidTapRestart() throws {
        // Arrange
        (1...2).forEach { _ in controller.scoreboard.gainedPoint() }
        (1...2).forEach { _ in controller.scoreboard.lostPoint() }
        let firstSubscription = controller.gameplayTimerSubscription

        // Act
        view.didTapRestart()

        // Assert
        XCTAssertEqual(controller.scoreboard.correctAttempts, 0)
        XCTAssertEqual(controller.scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(controller.currentWordPair, wordPairMock.pairs.last!)
        XCTAssertEqual(controller.scoreboard.gameState, .inProgress)
        XCTAssertNotNil(controller.gameplayTimerSubscription)
        XCTAssertNotEqual(controller.gameplayTimerSubscription, firstSubscription)
    }

}

private class WordPairManagerMock: PairManager {

    var pairs: [WordPair] = [WordPair(english: "one", spanish: "uno"), WordPair(english: "two", spanish: "dos")]
    private var counter = 0

    func newWordPair() -> WordPair {
        let pair = pairs[counter]
        counter += 1
        return pair
    }

    func isCorrectPair(english: String, spanish: String) -> Bool {
        return true
    }

    func isCorrectPair(_ wordPair: WordPair) -> Bool {
        return true
    }

}
