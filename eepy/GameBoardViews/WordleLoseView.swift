import SwiftUI

struct WordleLoseView: View {
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
            Text("You lost :( Try again!")
                .font(.largeTitle)
                .padding()
            Button() {
                playGame = true
            } label: {
                Text("Try Again")
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
    WordleLoseView()
}
