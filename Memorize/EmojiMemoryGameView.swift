//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
        
    var body: some View {
        VStack {
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            buttons
        }
        .padding()
    }
    
    var title: some View{
        HStack{
            Text("Memorize!").font(.largeTitle)
        }
    }
    
    var cards: some View{
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 85), spacing: 0)]) {
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.indigo)
    }
    
    var buttons: some View{
        HStack{
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .foregroundColor(.blue)
            .imageScale(.large)
            .font(.title)
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let rec = RoundedRectangle(cornerRadius: 20)
            Group {
                rec.fill(.background)
                rec.strokeBorder(lineWidth: 5)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            rec.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
