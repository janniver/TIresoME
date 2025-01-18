//
//  ContentView.swift
//  TIresoME
//
//  Created by Kailash Gautham on 18/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // MARK: Background
            
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).ignoresSafeArea()
            
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 60) {
            // MARK: Title
            
            Text("Time to have a good night's sleep!")
                .font(.headline)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.597982645, blue: 0.1653974652, alpha: 1)))
            
            // MARK: Sleeping Plan
            
            Text("16:8")
                .fontWeight(.semibold)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(.thinMaterial)
                .cornerRadius(20)
            
            
            // MARK: Progress Ring
            
            ProgressRing()
            
            HStack(spacing: 60) {
                // MARK: Start Time
                
                VStack(spacing: 5) {
                    Text("Start")
                        .opacity(0.7)
                    
                    Text(Date(), format: .dateTime.weekday().hour().minute().second())
                        .fontWeight(.bold)
                    
                }
                
                // MARK: End Time
                
                VStack(spacing: 5) {
                    Text("End")
                        .opacity(0.7)
                    
                    Text(Date().addingTimeInterval(16), format: .dateTime.weekday().hour().minute().second())
                        .fontWeight(.bold)
                    
                }
            }
            
            // MARK: Button
            
            Button {
                
            } label: {
                Text("Start Sleep")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
            }
            
        }
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
