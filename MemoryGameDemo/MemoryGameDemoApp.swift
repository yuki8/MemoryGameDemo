//
//  MemoryGameDemoApp.swift
//  MemoryGameDemo
//
//  Created by Yuki Muto on 1/18/23.
//

import SwiftUI

@main
struct MemoryGameDemoApp: App {    
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
