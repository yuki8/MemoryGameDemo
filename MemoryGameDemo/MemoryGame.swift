//
//  MemoryGame.swift
//  MemoryGameDemo
//
//  Created by Yuki Muto on 1/19/23.
//

import Foundation

struct MemoryGame<CardContent>{
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, getCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = getCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
    }
    
    func choose(_ card:Card) {
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
