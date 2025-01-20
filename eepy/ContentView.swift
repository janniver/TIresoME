import SwiftUI
import AVFoundation

enum CurrentScreen {
  case alarmClock
  case wordleGame
}

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @StateObject private var audioManager = AudioManager()

    var body: some View {
        ZStack {
            if Date() > timerManager.endTime {
                CompletionView()
                    .environmentObject(audioManager)
                    .onAppear {
                        audioManager.playAlarm()
                    }
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
                    .font(.title3)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(timerManager.timerState == .running ? .thinMaterial : .ultraThinMaterial)
                    .cornerRadius(20)
            }
            
            .disabled(timerManager.timerState == .running)
            
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
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .cornerRadius(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(timerManager.timerState == .running ? Color(#colorLiteral(red: 1, green: 0.6235, blue: 0.0392, alpha: 1)) : Color(#colorLiteral(red: 0.7490, green: 0.3529, blue: 0.9490, alpha: 1)))
                    )
            }
            
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
