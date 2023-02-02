//
//  MemoryGame.swift
//  MemoryGameDemo
//      Data Model of MomoryGame --- MVVM(Model View ViewModel)
//  Created by Yuki Muto on 1/19/23.
//

import Foundation

// Generic type CardContent represents any type which could be shown on the face of cards.
// They are provided by the function parameter passed in the initializer. -> see init()
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    // keep tracks of one and only card which is faceUp -- can be nil
    private var indexOfOneFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        // Being set only when the first of pair of cards are selected.
        // Previously opened cards are going to be flipped back again.
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numberOfPairsOfCards: Int, getCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = getCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    // Game logic of MomoryGame
    // What to do if the card is chosen
    mutating func choose(_ card:Card) {
        // Check valid card is seleccted
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            // If one card has been aleady open, then they can be checked for matching
            if let indexOfFirstCard = indexOfOneFaceUpCard {
                if cards[chosenIndex].content == cards[indexOfFirstCard].content {
                    cards[chosenIndex].isMatched = true
                    cards[indexOfFirstCard].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            // This is just the first card of pairs to open
            } else {
                indexOfOneFaceUpCard = chosenIndex
            }
        } // valid card
    }
    
    // A card has to be Identifiable from each other to distinguish to know
    // which card the player interacts with even when the symbols are same.
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
