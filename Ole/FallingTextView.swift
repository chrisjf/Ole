//
//  FallingTextView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-14.
//

import SwiftUI
import UIKit

struct FallingTextView: View {

    let text: String
    @Binding var isSummaryAlertShown: Bool
    @Binding var viewId: Int

    @State private var isFalling = false
    private let fallingAnimation = Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: false)

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .foregroundColor(isSummaryAlertShown ? .clear : .black)
            .position(x: UIScreen.main.bounds.width / 2,
                      y: isFalling ? UIScreen.main.bounds.height + heightOfLargeTitle : -heightOfLargeTitle)
            .edgesIgnoringSafeArea(.all)
            .id(viewId)
            .onAppear {
                animateFallingText()
            }
            .onChange(of: viewId, perform: { value in
                isFalling = false
                animateFallingText()
            })
    }

    private func animateFallingText() {
        // There is a bug where setting nil for the animation does not stop the animation.
        // So instead, use the default animation (which does not repeat),
        // as well as change the text color to clear to hide this one last default animation (done above).
        withAnimation(isSummaryAlertShown ? Animation.default : self.fallingAnimation) {
            self.isFalling = true
        }
    }

    var heightOfLargeTitle: CGFloat {
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        let maxSize = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: .infinity))
        let maxHeight = maxSize.height
        return maxHeight
    }

}

struct FallingTextView_Previews: PreviewProvider {
    static var previews: some View {
        FallingTextView(text: "español",
                        isSummaryAlertShown: .constant(false),
                        viewId: .constant(0))
    }
}
