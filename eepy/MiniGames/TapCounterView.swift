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
    @State private var isGameOver = false
    @State private var isSuccessful = false
    @Binding var isAlarmStopped: Bool // Binding to communicate with parent view

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 45) {
                Spacer()

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
                    Text("\(tapsRemaining)")
                        .font(.system(size: 150))
                        .bold()
                        .foregroundColor(.white)

                    Text("Time Remaining: \(timeRemaining)s")
                        .font(.title2)
                        .foregroundColor(Color.orange)

                    Button(" ") {
                        tapsRemaining -= 1
                    }
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.orange, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 55, height: 55)
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

struct TapCounterView_Previews: PreviewProvider {
    static var previews: some View {
        TapCounterView(isAlarmStopped: .constant(false))
    }
}
