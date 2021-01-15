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
    }

    func testGainPoint() throws {
        // Arrange
        XCTAssertEqual(scoreboard.isGameFinished, .inProgress)

        // Act
        scoreboard.gainedPoint()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 1)
        XCTAssertEqual(scoreboard.incorrectAttempts, 0)
        XCTAssertEqual(scoreboard.isGameFinished, .inProgress)
    }

    func testLoosePoint() throws {
        // Arrange
        XCTAssertEqual(scoreboard.isGameFinished, .inProgress)

        // Act
        scoreboard.lostPoint()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 1)
        XCTAssertEqual(scoreboard.isGameFinished, .inProgress)
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
    }

    func testShouldGameFinishUserWon() throws {
        // Arrange
        XCTAssertEqual(scoreboard.isGameFinished, .inProgress)

        // Act
        (1...13).forEach { _ in scoreboard.gainedPoint() }
        (1...2).forEach { _ in scoreboard.lostPoint() }

        // Assert
        XCTAssertEqual(scoreboard.correctAttempts, 13)
        XCTAssertEqual(scoreboard.incorrectAttempts, 2)
        XCTAssertEqual(scoreboard.isGameFinished, .userWon)
    }

    func testShouldGameFinishUserLost() throws {
        // Arrange
        XCTAssertEqual(scoreboard.isGameFinished, .inProgress)

        // Act
        (1...3).forEach { _ in scoreboard.lostPoint() }

        // Assert
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 3)
        XCTAssertEqual(scoreboard.isGameFinished, .userLost)
    }

}
