import SwiftUI

enum CurrentScreen {
  case alarmClock
  case wordleGame
}

struct ContentView: View {
    @StateObject var timerManager = TimerManager()
        
    var body: some View {
        ZStack {
            if Date() > timerManager.endTime + 1 {
                CompletionView()
            } else {
                // MARK: Background
                Color.black.ignoresSafeArea()
                
                content
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 60) {
            // MARK: Sleeping Plan
            
            Button {
                timerManager.selectDuration()
            } label: {
                Text(timerManager.timerDuration.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
            }
            
            
            // MARK: Progress Ring
            
            ProgressRing()
                .environmentObject(timerManager)
            
            HStack(spacing: 60) {
                // MARK: Start Time
                
                VStack(spacing: 5) {
                    Text(timerManager.timerState == .running ? "Started" : "Start")
                        .opacity(0.7)
                    
                    Text(timerManager.startTime, format: .dateTime.weekday().hour().minute())
                        .fontWeight(.bold)
                    
                }
                
                // MARK: End Time
                
                VStack(spacing: 5) {
                    Text(timerManager.timerState == .running ? "Ends" : "End")
                        .opacity(0.7)
                    
                    Text(timerManager.endTime, format: .dateTime.weekday().hour().minute())
                        .fontWeight(.bold)
                    
                }
            }
            
            // MARK: Button
            
            Button {
                timerManager.toggleTimerState()
            } label: {
                Text(timerManager.timerState == .running ? "Stop Alarm" : "Start Sleep")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
//                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(timerManager.timerState == .running ? Color(#colorLiteral(red: 1, green: 0.6235, blue: 0.0392, alpha: 1)) : Color(#colorLiteral(red: 0.7490, green: 0.3529, blue: 0.9490, alpha: 1)))
                    )
            }
            
        }
        .foregroundColor(.white)
    }}

// Kailash ContentView

//struct ContentView: View {
//    
//  @StateObject var game = GuessingGame()
//    @State private var currentScreen: CurrentScreen = .wordleGame
//  @State private var showStats = false
//
//  var body: some View {
//      switch currentScreen {
//      case .alarmClock:
//          VStack {
//              Text("Alarm Clock")
//                  .font(.title)
//                  .accessibilityAddTraits(.isHeader)
//              Button(action: {
//                  print("Before: \(currentScreen)")
//                    self.currentScreen = .wordleGame
//                    print("After: \(currentScreen)")
//              }) {
//                  Text("Switch Off Alarm")
//              }
//              .buttonStyle(.bordered)
//          }
//          Color("appBackground").edgesIgnoringSafeArea(.all)
//          .frame(alignment: .top)
//          .padding([.bottom], 10)
//      case .wordleGame:
//          VStack {
//              Text("Guess The Word")
//                  .font(.title)
//                  .foregroundStyle(.orange)
//                  .accessibilityAddTraits(.isHeader)
//              GameBoardView(game: game)
//              KeyboardView(game: game)
//                  .padding(5)
//              ActionBarView(
//                showStats: $showStats,
//                game: game
//              )
//          }
//          .frame(alignment: .top)
//          .padding([.bottom], 10)
//          .background(.black)
//      }
//  }
//}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
