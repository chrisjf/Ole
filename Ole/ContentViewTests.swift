//
//  ContentViewTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-14.
//

@testable import Ole
import XCTest

class ContentViewTests: XCTestCase {

    var view: ContentView!
    var controller: GameplayController!

    override func setUpWithError() throws {
        controller = GameplayController(wordPairManager: WordPairManagerMock())
        let gameplayView = GameplayView(gameplayController: controller)
        view = ContentView(gameplayView: gameplayView)
    }

    func testCreation() throws {
        // Act
        let view = ContentView()

        // Assert
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.gameplayController)
        XCTAssertTrue(view.gameIsCurrentlyInProgress)
    }

    func testGameFinished() throws {
        // Arrange
        XCTAssertTrue(view.gameIsCurrentlyInProgress)

        // Act
        (1...15).forEach { _ in controller.scoreboard.gainedPoint() }

        // Assert
        XCTAssertFalse(view.gameIsCurrentlyInProgress)
    }

    func testGameFinishedUserLost() throws {
        // Arrange
        XCTAssertTrue(view.gameIsCurrentlyInProgress)

        // Act
        (1...3).forEach { _ in controller.scoreboard.lostPoint() }

        // Assert
        XCTAssertFalse(view.gameIsCurrentlyInProgress)
    }

    func testGameStillInProgress() throws {
        // Arrange
        XCTAssertTrue(view.gameIsCurrentlyInProgress)

        // Act
        (1...10).forEach { _ in controller.scoreboard.gainedPoint() }

        // Assert
        XCTAssertTrue(view.gameIsCurrentlyInProgress)
    }

}

private class WordPairManagerMock: PairManager {

    func newWordPair() -> WordPair {
        return WordPair(english: "", spanish: "")
    }

    func isCorrectPair(english: String, spanish: String) -> Bool {
        return true
    }

    func isCorrectPair(_ wordPair: WordPair) -> Bool {
        return true
    }

}
