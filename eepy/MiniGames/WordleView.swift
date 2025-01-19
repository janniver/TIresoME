import SwiftUI

struct WordleView: View {
    @EnvironmentObject var audioManager: AudioManager

    @StateObject var game = GuessingGame()
    @State private var showStats = false
    @State private var isGameOver = false
    @State private var isSuccessful = false
    @State private var isAlarmStopped: Bool = false
    
    var body: some View {
        ZStack {
            if isAlarmStopped {
                ContentView()
                    .onAppear {
                        audioManager.stopAlarm()
                    }
            } else {
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
                      GameBoardView(game: game)
                      KeyboardView(game: game)
                          .padding(5)
                  }
                  .frame(alignment: .top)
                  .padding([.bottom], 10)
                  .background(.black)
                }
            }
        }
    }
    
    func resetGame() {
        isGameOver = false
        isSuccessful = false
        game.newGame()
    }
}

#Preview {
    WordleView()
        .environmentObject(AudioManager())
}



