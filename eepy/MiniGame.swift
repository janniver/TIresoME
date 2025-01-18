//
//  MiniGame.swift
//  eepy
//
//  Created by Ivan on 18/1/25.
//

import SwiftUI

enum MiniGame: Hashable {
    case sliderMatch
    case wordScramble
    case tapCounter
    case wordle
    case pong
    case circleTap

    @ViewBuilder
    func getView(isAlarmStopped: Binding<Bool>) -> some View {
        switch self {
        case .sliderMatch:
            SliderMatchView()
        case .wordScramble:
            WordScrambleView()
        case .tapCounter:
            TapCounterView()
        case .wordle:
            WordleView()
        case .pong:
            PongView()
        case .circleTap:
            CircleTapView()
        }
    }
}
