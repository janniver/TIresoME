import SwiftUI

enum CurrentScreen {
  case alarmClock
  case wordleGame
}

struct ContentView: View {
    
  @StateObject var game = GuessingGame()
  @State private var currentScreen: CurrentScreen = .alarmClock
  @State private var showStats = false

  var body: some View {
      Group {
          switch currentScreen {
          case .alarmClock:
              VStack {
                  Text("Alarm Clock")
                      .font(.title)
                      .accessibilityAddTraits(.isHeader)
                  Button(action: {
                      print("Before: \(currentScreen)")
                        self.currentScreen = .wordleGame
                        print("After: \(currentScreen)")
                  }) {
                      Text("Switch Off Alarm")
                  }
                  .buttonStyle(.bordered)
              }
              .frame(alignment: .top)
              .padding([.bottom], 10)
          case .wordleGame:
              VStack {
                  Text("Guess The Word")
                      .font(.title)
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
          }
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
