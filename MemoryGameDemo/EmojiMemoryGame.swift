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
    // Alias for long name -- clean up
    typealias Card = MemoryGame<String>.Card
    
    // Static to be accessible at initialization
    private static let emojis = ["🍏", "🍓", "🫐", "🍒", "🍑", "🥝", "🍇", "🍉", "🍋"]
    
    // Hide model and expose cards only
    @Published private var model: MemoryGame<String>
    var cards: [Card] {
        return model.cards
    }
    
    init() {
        model = MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
