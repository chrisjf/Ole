//
//  MenuView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-14.
//

import SwiftUI

struct MenuView: View {

    @Binding var isShown: Bool

    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: [Color.pastelYellow, Color.vibrantYellow]), startPoint: .top, endPoint: .bottom)
                .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height/3)
                .rotationEffect(.degrees(-10))

            Text(NSLocalizedString("menu.view.title", value: "¡OLÉ!", comment: "Menu view text"))
                .font(.system(size: 100, weight: .black, design: .monospaced))
                .foregroundColor(.vibrantPink)
                .kerning(-5)

            VStack {
                Spacer()
                GameplayButton(backgroundColor: .vibrantOrange,
                               icon: Image(systemName: "gamecontroller"),
                               title: NSLocalizedString("menu.view.start", value: "Start", comment: "Menu view button"),
                               action: {
                                withAnimation(Animation.easeInOut(duration: 0.35)) {
                                    isShown.toggle()
                                }
                               })
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    .padding()
            }
            .frame(maxWidth: UIScreen.main.bounds.width)

        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.vibrantPink, Color.purePink]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(isShown: .constant(true))
    }
}
