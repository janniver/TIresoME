import SwiftUI

struct WordleView: View {

    @StateObject var game = GuessingGame()
    @State private var showStats = false

    var body: some View {
        if game.status == .won {
            WordleWinView()
        } else if game.status == .lost {
            WordleLoseView()
        } else {
            VStack {
              Text("WordGuessr")
                  .font(.title)
                  .foregroundStyle(.purple)
                  .accessibilityAddTraits(.isHeader)
              GameBoardView(game: game)
              KeyboardView(game: game)
                  .padding(5)
              ActionBarView(
                showStats: $showStats,
                game: game
              )
          }
          .frame(alignment: .top)
          .padding([.bottom], 10)
          .background(.black)
        }
    }
}

struct WordleView_Previews: PreviewProvider {
    static var previews: some View {
        WordleView()
    }
}

