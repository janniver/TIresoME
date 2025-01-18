import Foundation
import SwiftUI

enum LetterStatus: String {
  case unknown = "Unknown"
  case notInWord = "Not In Word"
  case notInPosition = "In Word, but Wrong Position"
  case inPosition = "Correct and In Position"
}

struct GuessedLetter: Identifiable {
  var id = UUID()
  var letter: String
  var status: LetterStatus = .unknown
  var statusColor: Color {
    switch status {
    case .unknown:
      return .gray
    case .notInWord:
      return .gray
    case .notInPosition:
      return .orange
    case .inPosition:
      return .purple
    }
  }
}
