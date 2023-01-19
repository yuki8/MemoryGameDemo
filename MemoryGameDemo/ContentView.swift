//
//  ContentView.swift
//  MemoryGameDemo
//
//  Created by Yuki Muto on 1/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
                CardView().aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct CardView: View {
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill(.white)
            shape.strokeBorder(lineWidth: 3)
            Text("🥸").font(.largeTitle)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
