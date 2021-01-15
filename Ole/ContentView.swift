//
//  ContentView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-12.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private(set) var gameplayController: GameplayController
    private let gameplayView: GameplayView

    init(gameplayView: GameplayView = GameplayView()) {
        self.gameplayView = gameplayView
        self.gameplayController = gameplayView.gameplayController
    }

    var gameIsCurrentlyInProgress: Bool {
        return gameplayController.scoreboard.isGameFinished == .inProgress
    }

    var body: some View {
        if gameIsCurrentlyInProgress {
            gameplayView
        } else {
            MenuView(gameState: .init(get: { gameplayController.scoreboard.isGameFinished },
                                      set: { gameplayController.scoreboard.isGameFinished = $0}))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
