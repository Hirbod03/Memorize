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
            title
            ScrollView{
                cards
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
            ForEach(viewModel.cards.indices, id: \.self){ index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.indigo)
    }
    
    var buttons: some View{
        HStack{
            Button("Shuffle") {
                viewModel.shuffle()
            }
            //themeSelectButton(by: 1, symbol: "dog", text: "Animals")
            //Spacer()
            //themeSelectButton(by: 2, symbol: "soccerball", text: "Sports")
            //Spacer()
            //themeSelectButton(by: 3, symbol: "carrot", text: "Fruits")
        }
        .foregroundColor(.blue)
        .imageScale(.large)
        .font(.title)
    }
    
    
    
//    func themeSelectButton(by choice: Int, symbol: String, text: String) -> some View{
//         VStack{
//             Button(action: {
//                 if choice == 1 {
//                     theme = ["🦉", "🐠", "🐬","🐕","🦉", "🐠", "🐬","🐕"].shuffled()
//                     cardCount = 8
//                 }
//                 else if choice == 2 {
//                     theme = ["⚽️", "🏈", "🏀","🥎","⚾️","⚽️", "🏈", "🏀","🥎","⚾️"].shuffled()
//                     cardCount = 10
//                 }
//                 else if choice == 3{
//                     theme = ["🍎", "🍐", "🍌","🍉","🥝","🥥","🍓", "🍎", "🍐", "🍌","🍉","🥝","🥥","🍓"].shuffled()
//                     cardCount = 14
//                 }
//             }, label: {
//                 Image(systemName: symbol)
//             })
//             Text(text).font(.subheadline)
//         }
//    }
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
            rec.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
