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

    @ViewBuilder
    func getView(isAlarmStopped: Binding<Bool>) -> some View {
        switch self {
        case .sliderMatch:
            SliderMatchView(isAlarmStopped: isAlarmStopped)
        case .wordScramble:
            WordScrambleView(isAlarmStopped: isAlarmStopped)
        case .tapCounter:
            TapCounterView(isAlarmStopped: isAlarmStopped)
        case .wordle:
            WordleView(isAlarmStopped: isAlarmStopped)
        }
    }
}
