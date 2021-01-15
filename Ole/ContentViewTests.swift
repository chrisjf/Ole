//
//  ContentViewTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-14.
//

@testable import Ole
import XCTest

class ContentViewTests: XCTestCase {

    func testCreation() throws {
        // Act
        let view = ContentView()

        // Assert
        XCTAssertNotNil(view)
    }

}
