//
//  TranslationsParser.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-12.
//

import Foundation
import os

protocol Parser {
    var translationsList: [Translation] { get }
}

struct TranslationsParser: Parser {

    private(set) var translationsList: [Translation]

    init(resouceName: String) {
        guard !resouceName.isEmpty else {
            translationsList = []
            return
        }
        translationsList = TranslationsParser.loadTranslations(from: resouceName)
    }

    static private func loadTranslations(from resourceName: String) -> [Translation] {
        guard let listFilepath = Bundle.main.path(forResource: TranslationsParserConstants.dataFile, ofType: "") else {
            os_log("JSON file was not found", type: .error)
            return []
        }
        let fileUrl = URL(fileURLWithPath: listFilepath)

        guard let jsonData = try? Data(contentsOf: fileUrl) else {
            os_log("JSON file was not opened and converted to data", type: .error)
            return []
        }

        return mapJsonDataToTranslations(jsonData)
    }

    static func mapJsonDataToTranslations(_ jsonData: Data) -> [Translation] {
        let decoder = JSONDecoder()

        guard let preliminaryTranslations = try? decoder.decode(TranslationsList.self, from: jsonData) else {
            os_log("JSON file was not decoded", type: .error)
            return []
        }

        let translations = preliminaryTranslations.map { pair -> Translation in
            // split spanish by space-slash-space
            let spanishAlternatives = pair.spanish.components(separatedBy: " / ").map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }

            // remove leading/trailing whitespace
            let englishCleaned = pair.english.trimmingCharacters(in: .whitespacesAndNewlines)

            return Translation(english: englishCleaned, translations: spanishAlternatives)
        }

        return translations
    }

}

// MARK: - JSON Object

private struct TranslationPair: Decodable {
    let english: String
    let spanish: String

    enum CodingKeys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
}

private typealias TranslationsList = [TranslationPair]

// MARK: - Filename Constants

struct TranslationsParserConstants {
    static let dataFile = "words.json"
}
