import SwiftUI

struct WordleView: View {

    @StateObject var game = GuessingGame()
    @State private var showStats = false
    @State private var isGameOver = false
    @State private var isSuccessful = false
    @Binding var isAlarmStopped: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if game.status == .won || game.status == .lost {
                Button(game.status == .won ? "Stop Alarm" : "Try Again") {
                    if game.status == .won {
                        isAlarmStopped = true
                    } else {
                        resetGame()
                    }
                }
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(.thinMaterial)
                .cornerRadius(20)
                .foregroundColor(.white)
            } else {
                VStack {
                  Text("WordGuessr")
                      .font(.title)
                      .foregroundStyle(.purple)
                      .accessibilityAddTraits(.isHeader)
                  GameBoardView(game: game)
                  KeyboardView(game: game)
                      .padding(5)
                  ActionBarView(
                    showStats: $showStats,
                    game: game
                  )
              }
              .frame(alignment: .top)
              .padding([.bottom], 10)
              .background(.black)
            }
        }
    }
    
    func resetGame() {
        isGameOver = false
        isSuccessful = false
        game.newGame()
    }
}

struct WordleView_Previews: PreviewProvider {
    static var previews: some View {
        WordleView(isAlarmStopped: .constant(false))
    }
}



