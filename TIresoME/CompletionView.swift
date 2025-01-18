//
//  CompletionView.swift
//  TIresoME
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct CompletionView: View {
    var body: some View {
        VStack {
            Text("Time's Up!")
                .font(.largeTitle)
                .padding()
            Button("Back to Home") {
                // Handle navigation logic, if any
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    CompletionView()
}
