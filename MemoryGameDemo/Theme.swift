//
//  Theme.swift
//  MemoryGameDemo
//      Data Model of MomoryGame --- MVVM(Model View ViewModel)
//      Theme struct represents a theme, such as name, color,
//          and a set of generic content source on each card.
//  Created by Yuki Muto on 1/29/23.
//

import Foundation

struct Theme<CardContent> {
    let themeName: String
    let numberOfPairs: Int
    let themeColor: String
    let themeCardContents: Array<CardContent>
    
    init(themeName: String, numberOfPairs: Int, themeColor: String, source: Array<CardContent>) {
        self.themeName = themeName
        if numberOfPairs > source.count {
            self.numberOfPairs = source.count
        } else {
            self.numberOfPairs = numberOfPairs
        }
        self.themeColor = themeColor
        self.themeCardContents = Array(source.shuffled()[0..<self.numberOfPairs])
    }
    
    // If number of pairs to play is not specified, all source of CardContent is used.
    // If randomNumverOfPairs is true, random number(at least 2) of pairs will be assigned instead.
    init(themeName: String, themeColor: String, source: Array<CardContent>, randomNumberOfPairs: Bool = false) {
        var numberOfPairs: Int
        if randomNumberOfPairs {
            numberOfPairs = Int.random(in: 2...source.count)
        } else {
            numberOfPairs = source.count
        }
        self.init(themeName: themeName, numberOfPairs: numberOfPairs, themeColor: themeColor, source: source)
    }
}
