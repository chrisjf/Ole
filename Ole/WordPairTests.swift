//
//  WordPairTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-14.
//

@testable import Ole
import XCTest

class WordPairTests: XCTestCase {

    func testCreation() throws {
        // Act
        let pair = WordPair(english: "yes", spanish: "sí")

        // Assert
        XCTAssertNotNil(pair)
        XCTAssertEqual(pair.english, "yes")
        XCTAssertEqual(pair.spanish, "sí")
    }

    func testComparison() throws {
        // Arrange
        let pair1 = WordPair(english: "yes", spanish: "sí")
        let pair2 = WordPair(english: "yeah", spanish: "sí")
        let pair3 = WordPair(english: "yes", spanish: "sí")

        // Act
        let comparing1And2 = pair1 == pair2
        let comparing1And3 = pair1 == pair3

        // Assert
        XCTAssertFalse(comparing1And2)
        XCTAssertTrue(comparing1And3)
    }

}
