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
        // Act
        scoreboard.gainedPoint()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 1)
        XCTAssertEqual(scoreboard.incorrectAttempts, 0)
    }

    func testLoosePoint() throws {
        // Act
        scoreboard.lostPoint()

        // Assert
        XCTAssertNotNil(scoreboard)
        XCTAssertEqual(scoreboard.correctAttempts, 0)
        XCTAssertEqual(scoreboard.incorrectAttempts, 1)
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

}
