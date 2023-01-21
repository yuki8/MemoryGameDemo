//
//  EmojiMemoryGame.swift
//  MemoryGameDemo
//      Model View of MomoryGame --- MVVM(Model View ViewModel)
//          - Use class structure for sharing throgh app life
//          - Agent to connect Model and View in both direction
//  Created by Yuki Muto on 1/20/23.
//

import Foundation

class EmojiMemoryGame {
    // Static to be accessible at initialization
    private static let emojis = ["🍏", "🍓", "🫐", "🍒"]
    
    // Hide model and expose cards only
    private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    init() {
        model = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
}
