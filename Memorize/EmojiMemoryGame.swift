//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-12.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🍎","🍐","🍌","🍉","🥝","🥥","🍓","⚽️","🏈","🏀","🥎","⚾️","🦉","🐠","🐬","🐕"]
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 10) { index in
            if emojis.indices.contains(index){
                return emojis[index]
            }
            else{
                return "()"
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
