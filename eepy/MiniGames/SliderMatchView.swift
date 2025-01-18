//
//  SliderMatchView.swift
//  eepy
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

struct SliderMatchView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var sliderValue: Double = 50
    @State private var timeRemaining = 10
    @State private var isGameOver = false
    @State private var isSuccessful = false
    @Binding var isAlarmStopped: Bool // Binding to communicate with the parent view

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                if isGameOver {
                    Button(isSuccessful ? "Stop Alarm" : "Try Again") {
                        if isSuccessful {
                            isAlarmStopped = true // Notify the parent view to stop the alarm
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
//                    .background(
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(
//                                LinearGradient(
//                                    gradient: Gradient(colors: [Color.orange, Color.purple]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                    )
                } else {
                    Text("Target: \(targetValue)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()

                    Slider(value: $sliderValue, in: 0...100, step: 1)
                        .accentColor(.blue)
                        .padding(.horizontal, 40)

                    Text("Current: \(Int(sliderValue))")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("Time Remaining: \(timeRemaining)s")
                        .font(.title2)
                        .foregroundColor(.orange)
                        .padding()
                }

                Spacer()
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

struct SliderMatchView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMatchView(isAlarmStopped: .constant(false))
    }
}
