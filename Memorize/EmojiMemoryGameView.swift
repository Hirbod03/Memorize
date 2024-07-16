//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

struct Theme {
    let emojiArrayID: Int
    let name: String
    let imageName: String
    let pairs: Int
}

let themes = [
    Theme(emojiArrayID: 6, name: "Default", imageName: "face.smiling", pairs: 4),
    Theme(emojiArrayID: 0, name: "Fruits", imageName: "apple.logo", pairs: 6),
    Theme(emojiArrayID: 1, name: "Sports", imageName: "figure.tennis", pairs: 8),
    Theme(emojiArrayID: 2, name: "Animals", imageName: "dog", pairs: 10),
    Theme(emojiArrayID: 4, name: "Food", imageName: "fork.knife", pairs: 12),
    Theme(emojiArrayID: 3, name: "Weather", imageName: "cloud", pairs: 14),
    Theme(emojiArrayID: 5, name: "Travel", imageName: "airplane", pairs: 16)
]


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
            Button(
                action: { viewModel.shuffle() },
                label: { Image(systemName: "shuffle.circle") }
            )
            Spacer()
            Menu {
                ForEach(themes, id: \.emojiArrayID) { theme in
                    Button(action: { viewModel.newGame(emojiID: theme.emojiArrayID, theme.pairs) }) {
                        Text(theme.name)
                        Image(systemName: theme.imageName)
                    }
                }
            }
            label: { Image(systemName: "paintpalette") }
            Spacer()
            Button(
                action: { viewModel.newGame(Int.random(in:4...16)) },
                label: { Image(systemName: "plus.circle")}
            )
        }
        .foregroundColor(.blue)
        .font(.title)
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
