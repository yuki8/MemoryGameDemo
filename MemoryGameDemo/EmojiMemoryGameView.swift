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
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    // angles counterclockwise(+) start most right edge(0) refer to trig
                    // Set top to be 0 and increases clockwise to 360 (adjust by subtracting 90)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 30-90))
                        .opacity(DrawingConstants.circleOpacity)
                        .padding(DrawingConstants.circlePadding)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
        static let circleOpacity: CGFloat = 0.65
        static let circlePadding: CGFloat = 7
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
//        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
