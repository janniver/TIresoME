import SwiftUI

enum CurrentScreen {
  case alarmClock
  case wordleGame
}

struct ContentView: View {
    
  @StateObject var game = GuessingGame()
    @State private var currentScreen: CurrentScreen = .wordleGame
  @State private var showStats = false

  var body: some View {
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
          Color("appBackground").edgesIgnoringSafeArea(.all)
          .frame(alignment: .top)
          .padding([.bottom], 10)
      case .wordleGame:
          VStack {
              Text("Guess The Word")
                  .font(.title)
                  .foregroundStyle(.orange)
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
