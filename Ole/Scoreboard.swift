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
    @Published var isGameFinished: GameplayState = .inProgress

    func resetScore() {
        correctAttempts = 0
        incorrectAttempts = 0
    }

    func gainedPoint() {
        correctAttempts += 1
        shouldGameFinish()
    }

    func lostPoint() {
        incorrectAttempts += 1
        shouldGameFinish()
    }

    private func shouldGameFinish() {
        guard incorrectAttempts < 3 else {
            isGameFinished = .userLost
            return
        }

        guard correctAttempts + incorrectAttempts < 15 else {
            isGameFinished = .userWon
            return
        }
    }

}
