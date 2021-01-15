//
//  FallingTextViewTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-14.
//

@testable import Ole
import XCTest

class FallingTextViewTests: XCTestCase {

    func testCreation() throws {
        // Act
        let view = FallingTextView(text: "test", isSummaryAlertShown: .constant(false), viewId: .constant(0))

        // Assert
        XCTAssertNotNil(view)
    }

    func testHeightOfLargeTitle() throws {
        // Arrange
        let view = FallingTextView(text: "test", isSummaryAlertShown: .constant(false), viewId: .constant(0))

        // Act
        let height = view.heightOfLargeTitle

        // Assert
        XCTAssertTrue(height > 0)
    }

    func testHeightOfLargeTitleNone() throws {
        // Arrange
        let view = FallingTextView(text: "", isSummaryAlertShown: .constant(false), viewId: .constant(0))

        // Act
        let height = view.heightOfLargeTitle

        // Assert
        XCTAssertTrue(height == 0)
    }

}
