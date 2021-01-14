//
//  OleApp.swift
//  Ole
//
//  Created by Christopher Forbes on 2021-01-12.
//

import SwiftUI

@main
struct OleApp: App {

    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            // load the word list so the game is ready to play
            let _ = WordPairManager.shared
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}
