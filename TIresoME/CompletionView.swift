//
//  CompletionView.swift
//  eepy
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct CompletionView: View {
    @State private var returnHome = false
    @State private var selectedGame: MiniGame?
    private let miniGames: [MiniGame] = [
        .sliderMatch,
        .wordScramble,
        .tapCounter,
        .wordle
    ]

    var body: some View {
        if returnHome {
            ContentView() // Navigate back to home content
        } else {
            ZStack {
                Color.black.ignoresSafeArea()

                if let game = selectedGame {
                    game.getView(isAlarmStopped: $returnHome)
                } else {
                    defaultContent
                }
            }
        }
    }

    var defaultContent: some View {
        VStack {
            Text("Time's Up!")
                .font(.largeTitle)
                .padding()

            Button {
                selectedGame = miniGames.randomElement()
            } label: {
                Text("Stop")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
            }
        }
        .foregroundColor(.white)
    }
}

#Preview {
    CompletionView()
}
