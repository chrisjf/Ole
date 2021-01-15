//
//  GameplayView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import SwiftUI

struct GameplayView: View {

    @Binding var isMenuShown: Bool

    @ObservedObject var gameplayController = GameplayController()
    @State private var fallingTextViewId = 0
    @State private var isSummaryAlertShown: Bool = false

    var body: some View {
        ZStack(alignment: .top) {

            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(String(format: NSLocalizedString("gameplay.view.correct.attempts", value: "Correct Attempts: %d", comment: "Gameplay view label"), gameplayController.scoreboard.correctAttempts))
                        Text(String(format: NSLocalizedString("gameplay.view.incorrect.attempts", value: "Wrong Attempts: %d", comment: "Gameplay view label"), gameplayController.scoreboard.incorrectAttempts))
                    }
                    .font(.callout)
                    .padding()
                }

                Spacer()

                if !isSummaryAlertShown {
                    Text(gameplayController.currentWordPair.english)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                HStack {
                    GameplayButton(backgroundColor: .vibrantOrange,
                                   icon: Image(systemName: "checkmark.circle"),
                                   title: NSLocalizedString("gameplay.view.correct.button", value: "Correct", comment: "Gameplay view button"),
                                   action: {
                                    didTapCorrect()
                                   })

                    GameplayButton(backgroundColor: .vibrantPink,
                                   icon: Image(systemName: "xmark.circle"),
                                   title: NSLocalizedString("gameplay.view.incorrect.button", value: "Wrong", comment: "Gameplay view button"),
                                   action: {
                                    didTapIncorrect()
                                   })
                }
                .frame(maxWidth: .infinity)
                .padding()
            }

            FallingTextView(text: gameplayController.currentWordPair.spanish,
                            isSummaryAlertShown: $isSummaryAlertShown,
                            viewId: $fallingTextViewId)

        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelYellow, Color.vibrantYellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .modifier(SummaryAlert(isSummaryAlertShown: $isSummaryAlertShown,
                               didUserWin: didUserWin,
                               correctAttempts: gameplayController.scoreboard.correctAttempts,
                               incorrectAttempts: gameplayController.scoreboard.incorrectAttempts,
                               quitAction: didTapQuit,
                               restartAction: didTapRestart))
        .onChange(of: gameplayController.scoreboard.gameState) { newValue in
            guard gameplayController.scoreboard.gameState != .inProgress else {
                return
            }
            isSummaryAlertShown = true
            gameplayController.stopGameplay()
        }
    }

    private var didUserWin: Bool {
        return gameplayController.scoreboard.gameState == .userWon
    }

    private func refreshFallingAnimation() {
        // updating the view id will force SwiftUI to create a new view, thus resetting the view's position and animation
        fallingTextViewId += 1
    }

    func didTapCorrect() {
        gameplayController.tappedCorrectForCurrentWordPair()
        refreshFallingAnimation()
    }

    func didTapIncorrect() {
        gameplayController.tappedIncorrectForCurrentWordPair()
        refreshFallingAnimation()
    }

    func didTapQuit() {
        gameplayController.stopGameplay()
        gameplayController.resetGameplay()
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            isMenuShown.toggle()
        }
    }

    func didTapRestart() {
        gameplayController.resetGameplay()
        gameplayController.startGameplay()
        refreshFallingAnimation()
    }

}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView(isMenuShown: .constant(false))
    }
}
