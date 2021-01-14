//
//  GameplayController.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import Foundation

/**
 Responsible for showing new words (not the same as the last word pair), and updating the score
 */
class GameplayController: ObservableObject {

    @Published private(set) var currentWordPair: WordPair
    @Published var scoreboard = Scoreboard()

    private let wordPairManager: PairManager

    init(wordPairManager: PairManager = WordPairManager.shared) {
        self.wordPairManager = wordPairManager
        self.currentWordPair = wordPairManager.newWordPair()
    }

    func tappedCorrectForCurrentWordPair() {
        compareAnswersAndUpdateGameplay(usersAnswer: true)
    }

    func tappedIncorrectForCurrentWordPair() {
        compareAnswersAndUpdateGameplay(usersAnswer: false)
    }

    private func compareAnswersAndUpdateGameplay(usersAnswer: Bool) {
        // if the word pair is indeed correct, then augment the score, create a new word pair
        let actualAnswer = wordPairManager.isCorrectPair(currentWordPair)
        if usersAnswer == actualAnswer {
            scoreboard.gainedPoint()
        } else {
            scoreboard.lostPoint()
        }
        pickNewWordPair()
    }

    private func pickNewWordPair() {
        var newWordPair: WordPair

        repeat {
            newWordPair = wordPairManager.newWordPair()
        } while newWordPair == currentWordPair

        currentWordPair = newWordPair
    }

}
