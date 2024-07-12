//
//  ContentView.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🦉", "🐠", "🐬","🌘","🌑","🌒","🌓","🌔"]
    @State var cardCount = 2
    
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            buttons
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns:[GridItem(),GridItem()]) {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var buttons: some View{
        HStack{
            cardAdder
            cardRemover
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountButton(by offset: Int, symbol: String) -> some View{
         Button(action: {
             cardCount += offset
         }, label: {
             Image(systemName: symbol)
         })
         .disabled(cardCount + offset < 0 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountButton(by: -1, symbol: "minus.square")
    }
    
    var cardAdder: some View{
        cardCountButton(by: 1, symbol: "plus.app")
    }
    
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let rec = RoundedRectangle(cornerRadius: 20)
            Group {
                rec.fill(.white)
                rec.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            rec.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}










#Preview {
    ContentView()
}
