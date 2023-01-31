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
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static private var themes: Array<Theme<String>> = [
        Theme(themeName: "Fruits", numberOfPairs: 6,  themeColor: "orange", source: ["🍏", "🍓", "🫐", "🍒"]),
        Theme(themeName: "Sports", themeColor: "green", source: ["⚽️", "🏀", "🏈", "⚾️", "🏓", "🏆", "⛳️"]),
        Theme(themeName: "Vehicles", themeColor: "blue", source: ["🚗", "🚌", "🏎", "🚓", "🚒", "🚚", "🚜", "🛵", "🚃", "🚂", "🚁"], randomNumberOfPairs: true),
        Theme(themeName: "Smileys", numberOfPairs: 4,  themeColor: "yellow", source: ["😀", "😁", "🥹", "😍", "😎", "🥸", "😡"]),
        Theme(themeName: "Animals", themeColor: "brown", source: ["🐶", "🐱", "🐭", "🦊", "🐻", "🐼", "🐨", "🐯", "🐸", "🦉", "🦆"], randomNumberOfPairs: true),
        Theme(themeName: "Sweets", themeColor: "red", source: ["🍡", "🧁", "🍰", "🍩", "🍪", "🍦", "🍭"])
    ]
    
    private let colorConversion = ["red": Color.red, "orange": Color.orange, "green": Color.green, "blue": Color.blue,
                 "brown": Color.brown, "yellow": Color.yellow, "black": Color.black, "cyan": Color.cyan,
                 "pink": Color.pink, "purple": Color.purple, "gray": Color.gray, "mint": Color.mint]
    
    // Hide model and expose cards only
    @Published private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    @Published var gameTheme: Theme<String>
    
    static func createMemoryGame(theme: Theme<String>) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            theme.themeCardContents[pairIndex]
        }
    }
    
    init() {
        let gameTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
        self.gameTheme = gameTheme
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func getColor(color: String) -> Color {
        return colorConversion[color] ?? Color.teal
    }
    
    func newGame() {
        let gameTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
        self.gameTheme = gameTheme
    }
}
