//
//  GameplayController.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import Combine
import Foundation

/**
 Responsible for showing new words (not the same as the last word pair), and updating the score
 */
class GameplayController: ObservableObject {

    @Published private(set) var currentWordPair: WordPair
    @Published private(set) var gameplayTimerSubscription: AnyCancellable?
    @Published var scoreboard = Scoreboard()

    private let gameplayTimer: Timer.TimerPublisher = Timer.publish(every: 5, on: .main, in: .common)
    private let wordPairManager: PairManager

    init(wordPairManager: PairManager = WordPairManager.shared) {
        self.wordPairManager = wordPairManager
        self.currentWordPair = wordPairManager.newWordPair()

        startGameplay()
    }

    func startGameplay() {
        scoreboard.startGame()
        resetTimer()
    }

    func stopGameplay() {
        gameplayTimerSubscription = nil
    }

    func resetGameplay() {
        scoreboard.resetScore()
        pickNewWordPair()
    }

    func tappedCorrectForCurrentWordPair() {
        compareAnswersAndUpdateGameplay(usersAnswer: true)
        resetTimer()
    }

    func tappedIncorrectForCurrentWordPair() {
        compareAnswersAndUpdateGameplay(usersAnswer: false)
        resetTimer()
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

    func resetTimer() {
        // stop the timer
        gameplayTimerSubscription = nil

        // reset the timer
        gameplayTimerSubscription = gameplayTimer.autoconnect().sink(receiveValue: { _ in
            self.timeRanOut()
        })
    }

    func timeRanOut() {
        scoreboard.lostPoint()
        pickNewWordPair()
    }

}
