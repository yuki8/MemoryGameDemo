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
    static private var themes: Array<Theme<String>> = [
        Theme(themeName: "Fruit", numberOfPairs: 5, themeColor: "red", source: ["🍏", "🍓", "🫐", "🍒"])
    ]
    
    // Hide model and expose cards only
    @Published private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
   
    static func createMemoryGame(theme: Theme<String>) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.themeCardContents[pairIndex]
        }
    }
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.themes[0])
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
