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
    private var indexOfOneFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, getCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = getCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    // Game logic of MomoryGame
    // What to do if the card is chosen
    mutating func choose(_ card:Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let indexOfFirstCard = indexOfOneFaceUpCard {
                if cards[chosenIndex].content == cards[indexOfFirstCard].content {
                    cards[chosenIndex].isMatched = true
                    cards[indexOfFirstCard].isMatched = true
                } else {
                    
                }
                indexOfOneFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOneFaceUpCard = chosenIndex
            }
            
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    // A card has to be Identifiable from each other to distinguish to know
    // which card the player interacts with even when the symbols are same.
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
