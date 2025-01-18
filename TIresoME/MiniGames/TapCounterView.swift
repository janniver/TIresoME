//
//  TapCounterView.swift
//  itsallsotiresome
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

struct TapCounterView: View {
    @State private var tapCount = 0
    @State private var targetTaps = Int.random(in: 15...25)
    @State private var timeRemaining = 10
    @State private var isGameOver = false
    @State private var resultMessage = ""
    @Binding var isAlarmStopped: Bool // Binding to communicate with parent view

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                if isGameOver {
                    Text(resultMessage)
                        .font(.title2)
                        .foregroundColor(resultMessage.contains("Congrats") ?
                            Color.green :
                            Color.orange)
                        .multilineTextAlignment(.center)
                        .padding()

                    Button(resultMessage.contains("Congrats") ? "Stop Alarm" : "Try Again") {
                        if resultMessage.contains("Congrats") {
                            isAlarmStopped = true // Notify parent that the alarm is stopped
                        } else {
                            resetGame()
                        }
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.orange,
                                        Color.purple
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                } else {
                    Text("Target: \(targetTaps) taps")
                        .font(.title2)
                        .foregroundColor(.white)

                    Text("Taps: \(tapCount)")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    Text("Time Remaining: \(timeRemaining)s")
                        .font(.title2)
                        .foregroundColor(Color.orange)

                    Button("Tap Me!") {
                        tapCount += 1
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.orange,
                                        Color.purple
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
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
                resultMessage = tapCount == targetTaps ?
                    "Congrats. You are awake." :
                    "Wake up! Clearly you are still asleep 😴"
            }
        }
    }

    func resetGame() {
        tapCount = 0
        targetTaps = Int.random(in: 15...25)
        timeRemaining = 10
        isGameOver = false
        startTimer()
    }
}

struct TapCounterView_Previews: PreviewProvider {
    static var previews: some View {
        TapCounterView(isAlarmStopped: .constant(false))
    }
}
