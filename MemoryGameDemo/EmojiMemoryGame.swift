//
//  EmojiMemoryGame.swift
//  MemoryGameDemo
//      ViewModel of MomoryGame --- MVVM(Model View ViewModel)
//          - Use class structure for sharing through application
//          - Agent to connect Model and View in both direction
//          - ObservableObject protocol and @Published keyword for setting up
//            notification system to the views of any changes -- MVVM model
//  Created by Yuki Muto on 1/20/23.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    // Static to be accessible at initialization
    private static let emojis = ["🍏", "🍓", "🫐", "🍒"]
    
    // Hide model and expose cards only
    @Published private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    init() {
        model = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
