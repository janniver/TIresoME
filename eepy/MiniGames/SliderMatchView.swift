//
//  SliderMatchView.swift
//  eepy
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

struct SliderMatchView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    @State private var targetValue = Int.random(in: 0...100)
    @State private var sliderValue: Double = 50
    @State private var timeRemaining = 10
    @State private var isGameOver: Bool = false
    @State private var isSuccessful: Bool = false
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
                
                VStack(spacing: 20) {
                    if isGameOver {
                        if isSuccessful {
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
                        } else {
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
                        }
                    } else {
                        
                        Text("\(targetValue)")
                            .font(.system(size: 150))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Time Remaining: \(timeRemaining)s")
                            .font(.title2)
                            .foregroundColor(Color.orange)
                        
                        Slider(value: $sliderValue, in: 0...100, step: 1)
                            .accentColor(.clear)
                            .padding(.horizontal, 40)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.orange, .purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .mask(
                                    Capsule()
                                        .padding(.horizontal, 40)
                                )
                                .frame(height: 6)
                            )
                            .overlay(
                                    Circle()  // Custom slider knob
                                        .foregroundColor(.white)
                                        .shadow(radius: 3)
                                        .frame(width: 28, height: 28)
                                        .offset(x: CGFloat(sliderValue) / 100 * (UIScreen.main.bounds.width - 108) - (UIScreen.main.bounds.width - 108) / 2)  // Position knob
                                )
                        
                        Text("\(Int(sliderValue))")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear(perform: startTimer)
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                isGameOver = true
                isSuccessful = Int(sliderValue) == targetValue
            }
        }
    }

    func resetGame() {
        targetValue = Int.random(in: 0...100)
        sliderValue = 50
        timeRemaining = 10
        isGameOver = false
        isSuccessful = false
        startTimer()
    }
}

#Preview {
    SliderMatchView()
        .environmentObject(AudioManager())
}
