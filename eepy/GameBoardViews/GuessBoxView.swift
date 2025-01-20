import SwiftUI

struct GuessBoxView: View {
  var letter: GuessedLetter
  var size: Double
  var index: Int
  var body: some View {
    Text(letter.letter)
      .font(.title)
      .foregroundColor(.white)
      .bold()
      .frame(width: size, height: size)
      .background(.clear)
      .cornerRadius(size / 5.0)
      .overlay(
        Rectangle()
            .frame(height: (letter.status == .unknown ? 2.0 : 5.0))
            .foregroundColor(letter.statusColor)
            .padding(.top, size - 2)
      )
  }
}

struct GuessBoxView_Previews: PreviewProvider {
  static var previews: some View {
    let guess = GuessedLetter(letter: "S", status: .inPosition)
    GuessBoxView(letter: guess, size: 50, index: 1)
  }
}
