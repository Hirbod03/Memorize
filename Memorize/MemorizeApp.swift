//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hirbod Hosseini on 2024-07-11.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
