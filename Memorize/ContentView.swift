//
//  ContentView.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView(isHollow: false)
        }
        .padding()
        .foregroundColor(.blue)
    }
    
}


struct CardView: View {
    var isHollow: Bool = true
    
    var body: some View {
        ZStack {
            if isHollow {
                RoundedRectangle(cornerRadius: 20).foregroundColor(.white)
            }
            else {
                RoundedRectangle(cornerRadius: 20)
            }
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 10)
            Text("🫠").font(.largeTitle)
        }
    }
}










#Preview {
    ContentView()
}
