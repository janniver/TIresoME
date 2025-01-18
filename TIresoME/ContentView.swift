//
//  ContentView.swift
//  TIresoME
//
//  Created by Kailash Gautham on 18/1/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timerManager = TimerManager()
    
    var title: String {
        switch timerManager.timerState {
        case .idle:
            return "Are you ready for a good night's sleep?"
        case .running:
            return "You should now be sound asleep!"
        case .stopped:
            return "It is time to wakey wakey!"
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).ignoresSafeArea()
            
            if (Date() > timerManager.endTime + 1) {
                CompletionView()
            } else {
                content
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 60) {
            // MARK: Title
            
            Text(title)
                .font(.headline)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)))
            
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
                    
                    Text(timerManager.startTime, format: .dateTime.weekday().hour().minute().second())
                        .fontWeight(.bold)
                    
                }
                
                // MARK: End Time
                
                VStack(spacing: 5) {
                    Text(timerManager.timerState == .running ? "Ends" : "End")
                        .opacity(0.7)
                    
                    Text(timerManager.endTime, format: .dateTime.weekday().hour().minute().second())
                        .fontWeight(.bold)
                    
                }
            }
            
            // MARK: Button
            
            Button {
                timerManager.toggleTimerState()
            } label: {
                Text(timerManager.timerState == .running ? "Wake Up" : "Start Sleep")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(timerManager.timerState == .running ? .red : .blue)
                    )
            }
            
        }
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
