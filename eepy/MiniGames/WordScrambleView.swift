//
//  WordScrambleView.swift
//  eepy
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

struct WordScrambleView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    @State private var chosenWord : String = ""
    @State private var words: Set<String> = Set()
    @State private var scrambledWord = ""
    @State private var userAnswer: String = ""
    @State private var isGameOver = false
    @State private var isCorrect = false
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
                if isGameOver {
                    if isCorrect {
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
                                isGameOver = false
                                setupGame()
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
                    VStack(spacing: 60) {
                        Spacer()

                        Text("Unscramble:")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text(scrambledWord.map { String($0) }.joined(separator: "   "))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        TextField("Type your answer here", text: $userAnswer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 100)

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
                                        endPoint: .trailing)))
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            setupGame()
        }
    }

    func setupGame() {
        guard
          let fileUrl = Bundle.main.url(forResource: "common-words-5", withExtension: "txt"),
          let fileContents = try? String(contentsOf: fileUrl, encoding: .utf8) else {
            return
          }
        
        // Split the content into words and store them in a Set to avoid duplicates
        words = Set(fileContents.split { $0.isWhitespace || $0.isNewline }.map { String($0) })
        
        // Check if there are any words in the set
        if words.isEmpty {
            return
        }
        
        // Select a random word from the set
        if let randomWord = words.randomElement() {
            chosenWord = randomWord
        }
        
        print(chosenWord)

        scrambledWord = String(chosenWord.shuffled())
        userAnswer = ""
        isGameOver = false
    }

    func checkAnswer() {
        let sortedString1 = userAnswer.lowercased().sorted()
        let sortedString2 = chosenWord.lowercased().sorted()
        if sortedString1 == sortedString2 && words.contains(userAnswer.lowercased()) {
            isCorrect = true
        }
        
        isGameOver = true
    }
}

#Preview {
    WordScrambleView()
        .environmentObject(AudioManager())
}
