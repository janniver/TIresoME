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
    @State private var resultMessage: String = "Drag the slider to match the target!"
    @Binding var isAlarmStopped: Bool // Binding to communicate with the parent view

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

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

                Button(action: checkMatch) {
                    Text(resultMessage.contains("Success") ? "Stop Alarm" : "Check")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                }

                Text(resultMessage)
                    .font(.title3)
                    .foregroundColor(resultMessage.contains("Success") ? .green : .orange)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()
            }
        }
    }

    func checkMatch() {
        if resultMessage.contains("Success") {
            isAlarmStopped = true // Notify the parent view to stop the alarm
            return
        }

        let sliderIntValue = Int(sliderValue)
        if sliderIntValue == targetValue {
            resultMessage = "Success! Your alarm has stopped."
        } else {
            resultMessage = "Try again! You were \(abs(sliderIntValue - targetValue)) off."
        }
        targetValue = Int.random(in: 0...100)
    }
}

struct SliderMatchView_Previews: PreviewProvider {
    static var previews: some View {
        SliderMatchView(isAlarmStopped: .constant(false))
    }
}
