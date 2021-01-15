//
//  MenuView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-14.
//

import SwiftUI

struct MenuView: View {

    @Binding var gameState: GameplayState

    var body: some View {
        VStack {
            Text(NSLocalizedString("menu.view.won", value: "¡OLÉ!", comment: "Menu view text"))
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(gameState: .constant(.userWon))
    }
}
