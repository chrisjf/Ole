//
//  WordPair.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import Foundation

struct WordPair {
    let english: String
    let spanish: String
}

extension WordPair: Comparable {

    static func < (lhs: WordPair, rhs: WordPair) -> Bool {
        return lhs.english == rhs.english && lhs.spanish == rhs.spanish
    }

}
