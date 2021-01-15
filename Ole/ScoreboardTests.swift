//
//  ScoreboardTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-13.
//

@testable import Ole
import XCTest

class ScoreboardTests: XCTestCase {

    var scoreboard: Scoreboard!

    override func setUpWithError() throws {
        scoreboard = Scoreboard()
    }

    func testCreation() throws {
        // Act
        let scoreboard = Scoreboard()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(scoreboard.gameState, .none)
    }

    func testGainPoint() throws {
        // Arrange
        scoreboard.startGame()

        // Act
        scoreboard.gainedPoint()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 1)
        XCTAssertEqual(scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(scoreboard.gameState, .inProgress)
    }

    func testLoosePoint() throws {
        // Arrange
        scoreboard.startGame()

        // Act
        scoreboard.lostPoint()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 1)
        XCTAssertEqual(scoreboard.gameState, .inProgress)
    }

    func testStartGame() throws {
        // Arrange
        XCTAssertEqual(scoreboard.gameState, .none)

        // Act
        scoreboard.startGame()

        // Assert
        XCTAssertEqual(scoreboard.gameState, .inProgress)
    }

    func testReset() throws {
        // Arrange
        scoreboard.gainedPoint()
        scoreboard.lostPoint()
        XCTAssertEqual(scoreboard.correctAttempts, 1)
        XCTAssertEqual(scoreboard.incorrectAttempts, 1)

        // Act
        scoreboard.resetScore()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(scoreboard.gameState, .none)
    }

    func testShouldGameFinishUserWon() throws {
        // Arrange
        scoreboard.startGame()

        // Act
        (1...13).forEach { _ in scoreboard.gainedPoint() }
        (1...2).forEach { _ in scoreboard.lostPoint() }

        // Assert
        XCTAssertEqual(scoreboard.correctAttempts, 13)
        XCTAssertEqual(scoreboard.incorrectAttempts, 2)
        XCTAssertEqual(scoreboard.gameState, .userWon)
    }

    func testShouldGameFinishUserLost() throws {
        // Arrange
        scoreboard.startGame()

        // Act
        (1...3).forEach { _ in scoreboard.lostPoint() }

        // Assert
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 3)
        XCTAssertEqual(scoreboard.gameState, .userLost)
    }

}
