//
//  CircleTap.swift
//  eepy
//
//  Created by Zhiyang Lu on 19/01/2025.
//

import SwiftUI

struct CircleTapView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    @State private var clicked: Int = 0
    @State private var missedClick = false
    @State private var timer: Timer?
    @State private var circlePosition: CGPoint = .zero // Circle position
    @State private var diameter: Double = 100 // Circle size
    @State private var timeLimit: Int = 3
    @State private var completed: Bool = false
    @State private var screenBounds: CGRect = .zero // Screen bounds

    var body: some View {
        ZStack {
            if completed {
                ContentView()
                    .onAppear {
                        audioManager.stopAlarm()
                    }
            } else if missedClick {
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
            } else if clicked > 5 {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    .blur(radius: 10)

                    Button("Stop Alarm") {
                        completed = true
                    }
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .onAppear {
                        timer?.invalidate()
                    }
                    .opacity(0.8)
                }
            } else {
                // MARK: Background
                Color.black.ignoresSafeArea()
                    .onAppear {
                        updateCirclePosition()
                    }
                
                // Circle
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: diameter, height: diameter)
                    .position(circlePosition)
                    .onTapGesture {
                        updateCirclePosition()
                    }
            }
        }
    }
    
    func updateCirclePosition() {
        timer?.invalidate()
        diameter = 100.0
        clicked += 1
        timeLimit = 3
        
        // Calculate screen bounds
        screenBounds = UIScreen.main.bounds
        
        // Generate a random position within the screen bounds
        let x = CGFloat.random(in: diameter...(screenBounds.width - diameter))
        let y = CGFloat.random(in: diameter...(screenBounds.height - diameter))
        circlePosition = CGPoint(x: x, y: y)
        
        // Start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            diameter -= 25
            timeLimit -= 1
            if timeLimit <= 0 {
                missedClick = true
                timer?.invalidate() // Stop the timer
            }
        }
    }
    
    func resetGame() {
        clicked = 0
        missedClick = false
    }
}

#Preview {
    CircleTapView()
        .environmentObject(AudioManager())
}
