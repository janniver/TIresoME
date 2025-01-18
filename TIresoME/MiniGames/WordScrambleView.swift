//
//  WordScrambleView.swift
//  eepy
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

struct WordScrambleView: View {
    @State private var word = "APPLE"
    @State private var scrambledWord = ""
    @State private var userAnswer: String = ""
    @State private var message: String = ""
    @Binding var isAlarmStopped: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Text("Unscramble the word:")
                    .font(.headline)
                    .foregroundColor(.white)

                Text(scrambledWord)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                TextField("Type your answer here", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if !message.contains("Correct") {
                    Button("Submit") {
                        checkAnswer()
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 40)
                }

                if !message.isEmpty {
                    Text(message)
                        .font(.title3)
                        .foregroundColor(message.contains("Correct") ? .green : .orange)
                        .multilineTextAlignment(.center)
                        .padding()

                    if message.contains("Correct") {
                        Button("Stop Alarm") {
                            isAlarmStopped = true // Notify the parent view to stop the alarm
                        }
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                    }
                }

                Spacer()
            }
        }
        .onAppear {
            setupGame()
        }
    }

    func setupGame() {
        let words = ["APPLE", "ORANGE", "BANANA", "RAMBUTAN", "DURIAN"]
        word = words.randomElement()!
        scrambledWord = String(word.shuffled())
        userAnswer = ""
        message = ""
    }

    func checkAnswer() {
        if userAnswer.uppercased() == word {
            message = "Correct! Congrats. You are awake."
        } else {
            message = "Try Again!"
        }
    }
}

struct WordScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView(isAlarmStopped: .constant(false))
    }
}
