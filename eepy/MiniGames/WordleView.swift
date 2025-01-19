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
                if game.status == .won {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                        .blur(radius: 10)

                        Button("Stop Alarm") {
                            isAlarmStopped = true
                        }
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    }
                } else if game.status == .lost {
                    ZStack {
                        Color.black.ignoresSafeArea()

                        Button("Try Again") {
                            resetGame()
                        }
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                    }
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
