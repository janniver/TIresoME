import Foundation
import SwiftUI

enum GameState {
  case initializing
  case new
  case inprogress
  case won
  case lost
}

class GuessingGame: ObservableObject {
  let wordLength = 5
  let guessesAllowed = 6
  
  var dictionary: Dictionary
  var status: GameState = .initializing
  
  @Published var targetWord: String
  @Published var currentGuess = 0
  @Published var guesses: [Guess]
  
  init() {
    // 1
    dictionary = Dictionary(length: wordLength)
    // 2
    let totalWords = dictionary.commonWords.count
    let randomWord = Int.random(in: 0..<totalWords)
    let word = dictionary.commonWords[randomWord]
    // 3
    targetWord = word
    #if DEBUG
    print("selected word: \(word)")
    #endif
    // 4
    guesses = .init()
    guesses.append(Guess())
    status = .new
  }
  
  func addKey(letter: String) {
    if (status == .new) {
      status = .inprogress
    }
    guard status == .inprogress else {
      return
    }
    switch letter {
    case "<":
      deleteLetter()
    case ">":
      checkGuess()
    default:
      if guesses[currentGuess].word.count < wordLength {
        let newLetter = GuessedLetter(letter: letter)
        guesses[currentGuess].word.append(newLetter)
      }
    }
    
  }
  
  func deleteLetter() {
    let currentLetters = guesses[currentGuess].word.count
    guard currentLetters > 0 else { return }
    guesses[currentGuess].word.remove(at: currentLetters - 1)
  }
  
  func checkGuess() {
    guard guesses[currentGuess].word.count == wordLength else { return }
    if !dictionary.isValidWord(guesses[currentGuess].letters) {
      guesses[currentGuess].status = .invalidWord
      return
    }
    guesses[currentGuess].status = .complete
    var targetLettersRemaining = Array(targetWord)
    for index in guesses[currentGuess].word.indices {
      let stringIndex = targetWord.index(targetWord.startIndex, offsetBy: index)
      let letterAtIndex = String(targetWord[stringIndex])
      if letterAtIndex == guesses[currentGuess].word[index].letter {
        guesses[currentGuess].word[index].status = .inPosition
        if let letterIndex =
          targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
          targetLettersRemaining.remove(at: letterIndex)
        }
      }
    }
    for index in guesses[currentGuess].word.indices
      .filter({ guesses[currentGuess].word[$0].status == .unknown }) {
      // 2
      let letterAtIndex = guesses[currentGuess].word[index].letter
      // 3
      var letterStatus = LetterStatus.notInWord
      // 4
      if targetWord.contains(letterAtIndex) {
        // 5
        if let guessedLetterIndex =
          targetLettersRemaining.firstIndex(of: Character(letterAtIndex)) {
          letterStatus = .notInPosition
          targetLettersRemaining.remove(at: guessedLetterIndex)
        }
      }
      // 6
      guesses[currentGuess].word[index].status = letterStatus
    }
    
    if targetWord == guesses[currentGuess].letters {
        self.status = .won
        return
    }
    
    if currentGuess < guessesAllowed - 1 {
      guesses.append(Guess())
      currentGuess += 1
    } else {
      status = .lost
    }
  }
  
  func newGame() {
    let totalWords = dictionary.commonWords.count
    let randomWord = Int.random(in: 0..<totalWords)
    targetWord = dictionary.commonWords[randomWord]
    print("Selected word: \(targetWord)")

    currentGuess = 0
    guesses = []
    guesses.append(Guess())
    status = .new
  }

  
}

 extension GuessingGame {
  convenience init(word: String) {
    self.init()
    self.targetWord = word
  }

  static func inProgressGame() -> GuessingGame {
    let game = GuessingGame(word: "SMILE")
    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    return game
  }

  static func wonGame() -> GuessingGame {
    let game = GuessingGame(word: "SMILE")
    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    return game
  }

  static func lostGame() -> GuessingGame {
    let game = GuessingGame(word: "SMILE")

    game.addKey(letter: "P")
    game.addKey(letter: "I")
    game.addKey(letter: "A")
    game.addKey(letter: "N")
    game.addKey(letter: "O")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "O")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "P")
    game.addKey(letter: "O")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "T")
    game.addKey(letter: "A")
    game.addKey(letter: "R")
    game.addKey(letter: "E")
    game.addKey(letter: ">")

    game.addKey(letter: "M")
    game.addKey(letter: "I")
    game.addKey(letter: "L")
    game.addKey(letter: "E")
    game.addKey(letter: "S")
    game.addKey(letter: ">")

    game.addKey(letter: "S")
    game.addKey(letter: "M")
    game.addKey(letter: "E")
    game.addKey(letter: "L")
    game.addKey(letter: "L")
    game.addKey(letter: ">")

    return game
  }

 static func complexGame() -> GuessingGame {
   let game = GuessingGame(word: "THEME")

   game.addKey(letter: "E")
   game.addKey(letter: "E")
   game.addKey(letter: "R")
   game.addKey(letter: "I")
   game.addKey(letter: "E")
   game.addKey(letter: ">")

   game.addKey(letter: "S")
   game.addKey(letter: "T")
   game.addKey(letter: "E")
   game.addKey(letter: "E")
   game.addKey(letter: "L")
   game.addKey(letter: ">")

   game.addKey(letter: "T")
   game.addKey(letter: "H")
   game.addKey(letter: "E")
   game.addKey(letter: "M")
   game.addKey(letter: "E")
   game.addKey(letter: ">")

   return game
  }
 }
