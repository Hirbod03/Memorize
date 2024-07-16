//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-12.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static func selectTheme(choice: Int) -> [String]{
        switch choice{
            case 0: return (["🍎","🍐","🍌","🍉","🥝","🥥","🍓","🍇","🍊","🍋","🍒","🍍","🥭","🍑","🍈","🍏"].shuffled())
            case 1: return (["⚽️","🏈","🏀","🥎","⚾️","🎾","🏐","🏓","🏸","🥊","🥋","⛳️","🥌","🛹","🏒","🏑"].shuffled())
            case 2: return (["🦉","🐠","🐬","🐕","🐈","🦁","🐯","🐅","🐆","🐴","🦄","🐘","🦏","🐇","🦜","🦘"].shuffled())
            case 3: return (["☀️","🌤","⛅️","🌥","🌦","🌧","⛈","🌩","🌨","❄️","🌬","💨","🌪","🌫","🌈","☁️"].shuffled())
            case 4: return (["🍔","🍟","🌭","🍕","🥪","🌮","🌯","🍣","🍜","🍛","🍲","🍝","🍤","🍩","🍪","🍫"].shuffled())
            case 5: return (["✈️","🚀","🚁","🚂","🚢","🚗","🚙","🚕","🚌","🚎","🏨","🏦","🏥","🏪","🕌","🏛"].shuffled())
            case 6: return (["🍎","🍐","🍌","🍉","🥝","🥥","🍓","⚽️","🏈","🏀","🥎","⚾️","🦉","🐠","🐬","🐕"].shuffled())
            default: return (["🍎","🍐","🍌","🍉","🥝","🥥","🍓","⚽️","🏈","🏀","🥎","⚾️","🦉","🐠","🐬","🐕"].shuffled())
        }
    }
    
    // TODO: Add some sort of win/loss functionality
    
    private static func createMemoryGame(themeID: Int = 6, numOfPairs: Int = 10) -> MemoryGame<String>{
        let theme : [String] = selectTheme(choice: themeID)
        return MemoryGame(numberOfPairsOfCards: numOfPairs) { index in
            if theme.indices.contains(index){
                return theme[index]
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
    
    func newGame(themeID: Int = Int.random(in: 0...6),_ pairCount: Int = 10) {
        model = EmojiMemoryGame.createMemoryGame(themeID: themeID, numOfPairs: pairCount)
        model.shuffle()
    }
    
}
