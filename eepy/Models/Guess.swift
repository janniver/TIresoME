import Foundation

enum GuessStatus {
  case pending
  case complete
  case invalidWord
}

struct Guess: Identifiable {
  var id = UUID()
  var word: [GuessedLetter] = []
  var status: GuessStatus = .pending
  var letters: String {
    return word.reduce("") {
      partial, nextLetter in partial.appending(nextLetter.letter)
    }
  }
}
