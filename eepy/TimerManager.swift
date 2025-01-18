//
//  TimerManager.swift
//  eepy
//
//  Created by Zhiyang Lu on 18/01/2025.
//

import Foundation

enum TimerState {
    case idle
    case running
    case stopped
}

enum TimerDuration: String {
    case option1 = "10 Seconds"
    case option2 = "1 Minute"
    case option3 = "1:30"
    case option4 = "3:00"
    case option5 = "4:30"
    case option6 = "6:00"
    case option7 = "7:30"
    case option8 = "9:00"
    case option9 = "10:30"
    case option10 = "12:00"
    
    var duration: Double {
        switch self {
        case .option1:
            return 10
        case .option2:
            return 60
        case .option3:
            return 90 * 60
        case .option4:
            return 180 * 60
        case .option5:
            return 270 * 60
        case .option6:
            return 360 * 60
        case .option7:
            return 450 * 60
        case .option8:
            return 540 * 60
        case .option9:
            return 630 * 60
        case .option10:
            return 720 * 60
        }
    }
}

class TimerManager: ObservableObject {
    @Published private(set) var timerState: TimerState = .idle
    @Published private(set) var timerDuration: TimerDuration = .option1
    @Published private(set) var startTime: Date
    @Published private(set) var endTime: Date
    @Published private(set) var progress: Double = 0
    
    private var timer: Timer?
    
    init() {
        startTime = Date()
        endTime = Date().addingTimeInterval(TimerDuration.option1.duration)
        
        // Start the timer to refresh `startTime` and `endTime`
        startUpdatingTime()
    }
    
    func toggleTimerState() {
        if (timerState == .running) {
            timerState = .stopped
            startUpdatingTime()
        } else {
            timerState = .running
            stopUpdatingTime()
        }
    }
    
    func selectDuration() {
        switch timerDuration {
        case .option1:
            timerDuration = .option2
        case .option2:
            timerDuration = .option3
        case .option3:
            timerDuration = .option4
        case .option4:
            timerDuration = .option5
        case .option5:
            timerDuration = .option6
        case .option6:
            timerDuration = .option7
        case .option7:
            timerDuration = .option8
        case .option8:
            timerDuration = .option9
        case .option9:
            timerDuration = .option10
        case .option10:
            timerDuration = .option1
        }
    }
    
    /// Starts a timer that updates `startTime` and `endTime`
    func startUpdatingTime() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            // Update `startTime` and calculate `endTime`
            self.startTime = Date()
            self.endTime = self.startTime.addingTimeInterval(self.timerDuration.duration)
            self.progress = 0.0
        }
    }
    
    /// Stops the periodic time updates
    func stopUpdatingTime() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let elapsedTime = Date().timeIntervalSince(self.startTime)
            progress = elapsedTime / self.timerDuration.duration
        }
    }
}
