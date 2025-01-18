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
    @State private var isGameOver = false
    @Binding var isAlarmStopped: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if isGameOver {
                VStack {
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
                }
            } else {
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

                    Button("Submit") {
                        checkAnswer()
                    }
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.orange, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )

                    Spacer()
                }
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
        isGameOver = false
    }

    func checkAnswer() {
        if userAnswer.uppercased() == word {
            isGameOver = true
        }
    }
}

struct WordScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView(isAlarmStopped: .constant(false))
    }
}
