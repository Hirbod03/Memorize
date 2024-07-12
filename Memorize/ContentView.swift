//
//  ContentView.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

struct ContentView: View {
    
    @State var theme: [String] = ["🦉", "🐠", "🐬","🐕","🐈","🐁","🐇","🦨"]
    @State var cardCount = 8
    
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
        LazyVGrid(columns:[GridItem(),GridItem()]) {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: theme[index])
                    .aspectRatio(5/4, contentMode: .fit)
            }
        }
        .foregroundColor(.indigo)
    }
    
    var buttons: some View{
        HStack{
            themeSelectButton(by: 1, symbol: "dog", text: "Animals")
            Spacer()
            themeSelectButton(by: 2, symbol: "soccerball", text: "Sports")
            Spacer()
            themeSelectButton(by: 3, symbol: "carrot", text: "Fruits")
        }
        .foregroundColor(.blue)
        .imageScale(.large)
        .font(.title)
    }
    
    
    
    func themeSelectButton(by offset: Int, symbol: String, text: String) -> some View{
         VStack{
             Button(action: {
                 if offset == 1 {
                     theme = ["🦉", "🐠", "🐬","🐕","🦉", "🐠", "🐬","🐕"].shuffled()
                     cardCount = 8
                 }
                 else if offset == 2 {
                     theme = ["⚽️", "🏈", "🏀","🥎","⚾️","⚽️", "🏈", "🏀","🥎","⚾️"].shuffled()
                     cardCount = 10
                 }
                 else if offset == 3{
                     theme = ["🍎", "🍐", "🍌","🍉","🥝","🥥","🍓", "🍎", "🍐", "🍌","🍉","🥝","🥥","🍓"].shuffled()
                     cardCount = 14
                 }
             }, label: {
                 Image(systemName: symbol)
             })
             Text(text).font(.subheadline)
         }
    }

    
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let rec = RoundedRectangle(cornerRadius: 20)
            Group {
                rec.fill(.background)
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
