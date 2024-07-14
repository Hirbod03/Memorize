//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-12.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
        print("chose \(card)")
    }
    
    func index(of card: Card) -> Int{
        for index in cards.indices {
            if cards[index].id == card.id{
                return index
            }
        }
        return -1
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
    
}
