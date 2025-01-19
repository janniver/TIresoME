//
//  AudioManager.swift
//  eepy
//
//  Created by Zhiyang Lu on 19/01/2025.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?

    func playAlarm() {
        guard let soundURL = Bundle.main.url(forResource: "ringtone1", withExtension: "m4a") else {
            print("Alarm sound file not found!")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely until stopped
            audioPlayer?.play()
        } catch {
            print("Error playing alarm sound: \(error.localizedDescription)")
        }
    }

    func stopAlarm() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
