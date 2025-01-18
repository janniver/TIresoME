//
//  TapCounterView.swift
//  eepy
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

struct TapCounterView: View {
    @State private var tapsRemaining = Int.random(in: 15...25) // Start with target taps
    @State private var timeRemaining = 10
    @State private var isGameOver: Bool = false
    @State private var isSuccessful: Bool = false
    @State private var isAlarmStopped: Bool = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            if isAlarmStopped {
                ContentView()
            } else {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 45) {
                    if isGameOver {
                        Button(isSuccessful ? "Stop Alarm" : "Try Again") {
                            if isSuccessful {
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
                        Text("\(tapsRemaining)")
                            .font(.system(size: 150))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Time Remaining: \(timeRemaining)s")
                            .font(.title2)
                            .foregroundColor(Color.orange)
                        
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.orange, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                tapsRemaining -= 1
                                if (tapsRemaining < 0) {
                                    timer?.invalidate()
                                    isGameOver = true
                                    isSuccessful = false
                                }
                            }
                    }
                }
            }
        }
        .onAppear(perform: startTimer)
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                isGameOver = true
                isSuccessful = tapsRemaining == 0
            }
        }
    }

    func resetGame() {
        tapsRemaining = Int.random(in: 15...25)
        timeRemaining = 10
        isGameOver = false
        isSuccessful = false
        startTimer()
    }
}

#Preview {
    TapCounterView()
}
