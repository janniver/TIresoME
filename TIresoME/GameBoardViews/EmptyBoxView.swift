import SwiftUI

struct EmptyBoxView: View {
  var size: Double

  var body: some View {
      Text("")
        .font(.title)
        .foregroundColor(Color(UIColor.systemBackground))
        .frame(width: size, height: size)
        .cornerRadius(size / 5.0)
        .overlay(
          RoundedRectangle(cornerRadius: size / 5.0)
                .stroke(.white, lineWidth: 3)
        )
  }
}

struct EmptyBoxView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyBoxView(size: 50.0)
  }
}
