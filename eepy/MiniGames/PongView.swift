import SwiftUI

struct PongView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    @State private var ballPosition = CGPoint(x: 200, y: 300)
    @State private var ballVelocity = CGPoint(x: 4, y: 4)
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    @State private var paddlePosition = CGFloat(UIScreen.main.bounds.width / 2)
    @State private var isGameOver = false
    @State private var target = 5
    @State private var timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    @State private var isAlarmStopped: Bool = false

    var paddleWidth: CGFloat = 120
    var paddleHeight: CGFloat = 20
        
    var body: some View {
        ZStack {
            if isAlarmStopped {
                ContentView()
                    .onAppear {
                        audioManager.stopAlarm()
                    }
            } else {
                Color.black.ignoresSafeArea(.all)
                
                if !isGameOver {
                    Text("\(target)")
                        .font(.system(size: 150))
                        .bold()
                        .foregroundColor(.white)
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 30, height: 30)
                        .position(ballPosition)
                    
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(20)
                        .frame(width: paddleWidth, height: paddleHeight)
                        .position(x: paddlePosition, y: screenHeight / 1.2)
                    
                } else {
                    Button(target <= 0 ? "Stop Alarm" : "Try Again") {
                        if target <= 0 {
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
                }
            }
        }
        .gesture(DragGesture()
            .onChanged { value in
                paddlePosition = value.location.x
            }
        )
        .onReceive(timer) { _ in
            guard !isGameOver else { return }
            updateGame()
        }
        .onAppear {
            resetGame()
        }
    }
    
    func updateGame() {
        ballPosition.x += ballVelocity.x
        ballPosition.y += ballVelocity.y

        if ballPosition.x <= 10 || ballPosition.x >= screenWidth - 10 {
            ballVelocity.x *= -1
        }
        if ballPosition.y <= 10 {
            ballVelocity.y *= -1
        }

        if ballPosition.y >= screenHeight / 1.2 - 20 &&
            ballPosition.y <= screenHeight / 1.2 - 10 &&
            ballPosition.x >= paddlePosition - paddleWidth / 2 &&
            ballPosition.x <= paddlePosition + paddleWidth / 2 {
            ballVelocity.y *= -1
            target -= 1
            if target <= 0 {
                isGameOver = true
            }
        }

        if ballPosition.y >= screenHeight / 1.2 + 55 {
            isGameOver = true
            timer.upstream.connect().cancel()
        }
    }
    
    func resetGame() {
        ballPosition = CGPoint(x: 200, y: 300)
        ballVelocity = CGPoint(x: 6, y: 6)
        paddlePosition = CGFloat(UIScreen.main.bounds.width / 2)
        isGameOver = false
        target = 5
        timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    PongView()
        .environmentObject(AudioManager())
}
