//
//  SummaryAlertView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-14.
//

import SwiftUI

struct SummaryAlert: ViewModifier {

    @Binding var isSummaryAlertShown: Bool
    let didUserWin: Bool
    let correctAttempts: Int
    let incorrectAttempts: Int
    let quitAction: (() -> Void)
    let restartAction: (() -> Void)

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isSummaryAlertShown) { () -> Alert in
                Alert(title: Text(didUserWin ? NSLocalizedString("gameplay.view.won", value: "You Won!", comment: "Gameplay view text") : NSLocalizedString("gameplay.view.lost", value: "Game Over", comment: "Gameplay view text")),
                      message: Text(String(format: NSLocalizedString("gameplay.view.score", value: "Correct: %d\nWrong: %d", comment: "Gameplay view text"), correctAttempts, incorrectAttempts)),
                      primaryButton: .cancel(Text(NSLocalizedString("gameplay.view.quit", value: "Quit", comment: "Gameplay view button")), action: {
                        quitAction()
                      }),
                      secondaryButton: .default(Text(NSLocalizedString("gameplay.view.restart", value: "Restart", comment: "Gameplay view button")), action: {
                        restartAction()
                      }))
            }
    }

}

struct SummaryAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Press play to see alert")
            .modifier(SummaryAlert(isSummaryAlertShown: .constant(true), didUserWin: false, correctAttempts: 4, incorrectAttempts: 3, quitAction: {}, restartAction: {}))
    }
}
