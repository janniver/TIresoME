import SwiftUI

struct CurrentGuessView: View {
  @Binding var guess: Guess
  var wordLength: Int

  var unguessedLetters: Int {
    wordLength - guess.word.count
  }
  var body: some View {
    GeometryReader { proxy in
      HStack {
        Spacer()
        let width = (proxy.size.width - 40) / 5 * 0.8
        ForEach(guess.word.indices, id: \.self) { index in
          let letter = guess.word[index]
          GuessBoxView(letter: letter, size: width, index: index)
        }
        ForEach(0..<unguessedLetters, id: \.self) { _ in
          EmptyBoxView(size: width)
        }
        Spacer()
      }
      .padding(5.0)
      .overlay(
        Group {
          if guess.status == .invalidWord {
            Text("Word not in dictionary.")
              .padding(10)
              .foregroundColor(.black)
              .background(.white)
              .opacity(1)
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(.white, lineWidth: 1)
              )
              .onAppear {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                  guess.status = .pending
                }
              }
          }
        }
      )
    }
  }
}

struct CurrentGuessView_Previews: PreviewProvider {
  static var previews: some View {
    let guessedLetter = GuessedLetter(letter: "S", status: .inPosition)
    let guessedLetter2 = GuessedLetter(letter: "A", status: .notInPosition)
    
    let guess = Guess(
      word: [guessedLetter, guessedLetter2],
      status: .invalidWord
    )
    CurrentGuessView(
      guess: .constant(guess),
      wordLength: 5
    )
  }
}
