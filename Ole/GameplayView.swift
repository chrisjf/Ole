//
//  GameplayView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import SwiftUI

struct GameplayView: View {

    @ObservedObject var gameplayController = GameplayController()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(format: NSLocalizedString("game.view.correct.attempts", value: "Correct Attempts: %d", comment: "Game view label"), gameplayController.scoreboard.correctAttempts))
                    Text(String(format: NSLocalizedString("game.view.incorrect.attempts", value: "Wrong Attempts: %d", comment: "Game view label"), gameplayController.scoreboard.incorrectAttempts))
                }
                .font(.callout)
                .padding()
            }

            Spacer()

            Text(gameplayController.currentWordPair.spanish)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.bottom)

            Text(gameplayController.currentWordPair.english)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Spacer()

            HStack {
                GameplayButton(backgroundColor: .vibrantOrange,
                               icon: Image(systemName: "checkmark.circle"),
                               title: NSLocalizedString("game.view.correct.button", value: "Correct", comment: "Game view button"),
                               action: {
                                gameplayController.tappedCorrectForCurrentWordPair()
                               })

                GameplayButton(backgroundColor: .vibrantPink,
                               icon: Image(systemName: "xmark.circle"),
                               title: NSLocalizedString("game.view.incorrect.button", value: "Wrong", comment: "Game view button"),
                               action: {
                                gameplayController.tappedIncorrectForCurrentWordPair()
                               })
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelYellow, Color.vibrantYellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView()
    }
}
