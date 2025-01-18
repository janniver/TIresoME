//
//  ProgressRing.swift
//  eepy
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var timerManager: TimerManager
    var body: some View {
        ZStack {
            // MARK: Placeholder Ring
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.white)
                .opacity(0.2)
            
            // MARK: Colored Ring
            
            Circle()
                .trim(from: 0.0, to: min(timerManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6235, blue: 0.0392, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.6235, blue: 0.0392, alpha: 1)), Color(#colorLiteral(red: 0.7490, green: 0.3529, blue: 0.9490, alpha: 1)), Color(#colorLiteral(red: 0.7490, green: 0.3529, blue: 0.9490, alpha: 1)), Color(#colorLiteral(red: 0.7490, green: 0.3529, blue: 0.9490, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.6235, blue: 0.0392, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.6235, blue: 0.0392, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration:1.0), value: min(timerManager.progress, 1.0))
            
            VStack(spacing: 30) {
                // MARK: Elapsed Time
                
                VStack(spacing: 5) {
                    Text("Elapsed Time")
                        .opacity(0.7)
                    
                    Text(formatTime(min(Date().timeIntervalSince(timerManager.startTime), timerManager.timerDuration.duration)))
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                // MARK: Remaining Time
                
                VStack(spacing: 5) {
                    Text("Remaining Time")
                        .opacity(0.7)
                    
                    Text(formatTime(max(timerManager.endTime.timeIntervalSince(Date()) + 1, 0)))
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
    }
    
    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(TimerManager())
    }
}
