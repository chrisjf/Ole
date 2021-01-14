//
//  Scoreboard.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import Foundation

class Scoreboard: ObservableObject {

    @Published private(set) var correctAttempts: Int = 0
    @Published private(set) var incorrectAttempts: Int = 0

    func resetScore() {
        correctAttempts = 0
        incorrectAttempts = 0
    }

    func gainedPoint() {
        correctAttempts += 1
    }

    func lostPoint() {
        incorrectAttempts += 1
    }
}
