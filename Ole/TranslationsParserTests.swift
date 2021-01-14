//
//  TranslationsParserTests.swift
//  OleTests
//
//  Created by Christopher Forbes on 2021-01-12.
//

@testable import Ole
import XCTest

class TranslationsParserTests: XCTestCase {

    func testCreation() throws {
        // Act
        let parser = TranslationsParser(resouceName: TranslationsParserConstants.dataFile)

        // Assert
        XCTAssertNotNil(parser)
        XCTAssertEqual(parser.translationsList.count, 297)
    }

    func testCreationWithoutResource() throws {
        // Act
        let parser = TranslationsParser(resouceName: "")

        // Assert
        XCTAssertNotNil(parser)
        XCTAssertEqual(parser.translationsList.count, 0)
    }

    func testMalformedJson() throws {
        // Arrange
        let json = """
        [
          {
            "text_eng":"hello",
            "text_spa":
          }
        ]
        """
        let jsonData = json.data(using: .utf8)!

        // Act
        let translations = TranslationsParser.mapJsonDataToTranslations(jsonData)

        // Assert
        XCTAssertNotNil(translations)
        XCTAssertEqual(translations.count, 0)
    }

    func testTrickyJson() throws {
        // Arrange
        let json = """
        [
          {
            "text_eng":"hello",
            "text_spa":"hola / bueno/as / buenos días / buen día /     saludos    "
          }
        ]
        """
        let jsonData = json.data(using: .utf8)!

        // Act
        let translations = TranslationsParser.mapJsonDataToTranslations(jsonData)

        // Assert
        XCTAssertNotNil(translations)
        XCTAssertEqual(translations.count, 1)
        XCTAssertEqual(translations.first!.translations.count, 5)
        XCTAssertEqual(translations.first!.translations[1], "bueno/as")
        XCTAssertEqual(translations.first!.translations.last!, "saludos")
    }

}
