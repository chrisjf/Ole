//
//  ContentView.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-12.
//

import SwiftUI

struct ContentView: View {

    @State private var isMenuShown = false

    var body: some View {
        if !isMenuShown {
            GameplayView(isMenuShown: $isMenuShown)
        } else {
            MenuView(isShown: $isMenuShown)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
