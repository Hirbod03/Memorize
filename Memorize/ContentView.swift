//
//  ContentView.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

struct ContentView: View {
    var i: Int = 5
    var s: String = "Hirbod"
    
    
    var body: some View {
        HStack {
            CardView()
            CardView()
        }
        .padding()
        .foregroundColor(Color.green)
    }
}


struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 10)
            Text("🫠").font(.largeTitle)
        }
    }
}










#Preview {
    ContentView()
}
