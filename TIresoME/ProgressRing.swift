//
//  ProgressRing.swift
//  TIresoME
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var timerManager: TimerManager
    var body: some View {
        ZStack {
            // MARK: Placeholder Ring
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.white)
                .opacity(0.2)
            
            // MARK: Colored Ring
            
            Circle()
                .trim(from: 0.0, to: min(timerManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)), Color(#colorLiteral(red: 0.3780175447, green: 0.614254117, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3780175447, green: 0.614254117, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3780175447, green: 0.614254117, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration:1.0), value: min(timerManager.progress, 1.0))
            
            VStack(spacing: 30) {
                // MARK: Elapsed Time
                
                VStack(spacing: 5) {
                    Text("Elapsed Time")
                        .opacity(0.7)
                    
                    Text(timerManager.startTime, style: .timer)
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top)
                
                // MARK: Remaining Time
                
                VStack(spacing: 5) {
                    Text("Remaining Time")
                        .opacity(0.7)
                    
                    Text(timerManager.endTime, style: .timer)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
    }

}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(TimerManager())
    }
}
