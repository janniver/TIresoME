//
//  CompletionView.swift
//  eepy
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct CompletionView: View {
    @State private var returnHome = false
    @State private var playGame = false
    var body: some View {
        if returnHome {
            ContentView()
        } else if playGame {
            WordleView()
        } else {
            // MARK: Background
            Color.black.ignoresSafeArea()
            
            content
        }
    }
    
    var content: some View {
        VStack {
            Text("Time's Up!")
                .font(.largeTitle)
                .padding()
            Button() {
                playGame = true
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
