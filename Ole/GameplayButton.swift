//
//  GameplayButton.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-13.
//

import SwiftUI

struct GameplayButton: View {

    let backgroundColor: Color
    let icon: Image
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            HStack (alignment: .center, spacing: 1) {
                icon
                    .font(Font.system(.title2).bold())
                    .imageScale(.small)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        })
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .lineSpacing(4)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [backgroundColor.opacity(0.8), backgroundColor]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(16)
    }

}

struct GameplayButton_Previews: PreviewProvider {
    static var previews: some View {
        GameplayButton(backgroundColor: Color.orange, icon: Image(systemName: "star"), title: "Button", action: {})
    }
}
