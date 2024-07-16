//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-12.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: [Card]
    private var score: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        score = 0
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    var onlyFaceUpCard: Int? {
        get{ cards.indices.filter { index in cards[index].isFaceUp}.only }
        set{ cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatch = onlyFaceUpCard{
                    let match : Bool = cards[chosenIndex].content == cards[potentialMatch].content
                    if match{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatch].isMatched = true
                        score += 2
                    }
                    if cards[chosenIndex].wasSeen && !match {
                        score -= 1
                    }
                    if cards[potentialMatch].wasSeen && !match {
                        score -= 1
                    }
                    if !match {
                        cards[potentialMatch].wasSeen = true
                        cards[chosenIndex].wasSeen = true
                    }
                    
                } else {
                    onlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    func getScore() -> Int {
        return score
    }
    
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var wasSeen: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
    
}


extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
