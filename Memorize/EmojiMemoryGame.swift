//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-12.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static var defaultTheme = ["🍎","🍐","🍌","🍉","🥝","🥥","🍓","⚽️","🏈","🏀","🥎","⚾️","🦉","🐠","🐬","🐕"].shuffled()
    private static let fruitTheme = ["🍎","🍐","🍌","🍉","🥝","🥥","🍓","🍇","🍊","🍋","🍒","🍍","🥭","🍑","🍈","🍏"].shuffled()
    private static let sportsTheme = ["⚽️","🏈","🏀","🥎","⚾️","🎾","🏐","🏓","🏸","🥊","🥋","⛳️","🥌","🛹","🏒","🏑"].shuffled()
    private static let animalTheme = ["🦉","🐠","🐬","🐕","🐈","🦁","🐯","🐅","🐆","🐴","🦄","🐘","🦏","🐇","🦜","🦘"].shuffled()
    private static let weatherTheme = ["☀️","🌤","⛅️","🌥","🌦","🌧","⛈","🌩","🌨","❄️","🌬","💨","🌪","🌫","🌈","☁️"].shuffled()
    private static let foodTheme = ["🍔","🍟","🌭","🍕","🥪","🌮","🌯","🍣","🍜","🍛","🍲","🍝","🍤","🍩","🍪","🍫"].shuffled()
    private static let travelTheme = ["✈️","🚀","🚁","🚂","🚢","🚗","🚙","🚕","🚌","🚎","🏨","🏦","🏥","🏪","🕌","🏛"].shuffled()
    
    
    private static func emojisForSelectedTheme(choice: Int) -> [String]{
        switch choice{
            case 0: return fruitTheme
            case 1: return sportsTheme
            case 2: return animalTheme
            case 3: return weatherTheme
            case 4: return foodTheme
            case 5: return travelTheme
            default: return defaultTheme
        }
    }
    
    private static func createMemoryGame(theme: [String], numOfPairs: Int) -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: numOfPairs) { index in
            if theme.indices.contains(index){
                return theme[index]
            }
            else{
                return "()"
            }
        }
    }
        
    @Published private var model = createMemoryGame(theme: defaultTheme, numOfPairs: 10)
    
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
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.defaultTheme, numOfPairs: 10)
    }
    
    // TODO: Add theme selector
    
}
