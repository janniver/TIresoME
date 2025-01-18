//
//  ProgressRing.swift
//  TIresoME
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import SwiftUI

struct ProgressRing: View {
    @State var progress = 0.0
    var body: some View {
        ZStack {
            // MARK: Placeholder Ring
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // MARK: Colored Ring
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)), Color(#colorLiteral(red: 0.3780175447, green: 0.614254117, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3780175447, green: 0.614254117, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3780175447, green: 0.614254117, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration:1.0), value: progress)
            
            VStack(spacing: 30) {
                // MARK: Elapsed Time
                
                VStack(spacing: 5) {
                    Text("Elapsed Time")
                        .opacity(0.7)
                    
                    Text("0:00")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top)
                
                // MARK: Remaining Time
                
                VStack(spacing: 5) {
                    Text("Remaining Time")
                        .opacity(0.7)
                    
                    Text("0:00")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onAppear {
            progress = 1.0
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
    }
}
