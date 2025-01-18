//
//  CompletionView.swift
//  TIresoME
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct CompletionView: View {
    @State private var returnHome = false
    var body: some View {
        if returnHome {
            ContentView()
        } else {
            content
        }
    }
    
    var content: some View {
        VStack {
            Text("Time's Up!")
                .font(.largeTitle)
                .padding()
            Button() {
                returnHome = true
            } label: {
                Text("Stop")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
            }
        }
    }
}

#Preview {
    CompletionView()
}
