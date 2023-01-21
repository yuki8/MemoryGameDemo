//
//  ContentView.swift
//  MemoryGameDemo
//      View for MemoryGame --- MVVM(Model View ViewModel)
//  Created by Yuki Muto on 1/18/23.
//

import SwiftUI

struct ContentView: View {
    let viewModel: EmojiMemoryGame       // ViewModel connection
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(viewModel.cards) {card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
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
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
