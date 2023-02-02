//
//  EmojiMemoryGameView.swift
//  MemoryGameDemo
//      View for MemoryGame --- MVVM(Model View ViewModel)
//      - Keeps track of Model changes by adding @ObservedObject keyword to
//        ViewModel which connects Model and View
//  Created by Yuki Muto on 1/18/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Observe the change in viewModel
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                // ????(Weird) Adding text makes the zstack size changed.
                // Adding .padding(any negative) fixed this. Try comment it out
                Text(card.content).font(.largeTitle).padding(-1)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
