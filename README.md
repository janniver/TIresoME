# *eepy*: The Evil Alarm Clock
 *eepy* is an innovative alarm clock iOS app designed to make sure you're fully awake by the time you stop your alarm. To turn off the alarm, users must complete engaging and challenging mini-games. Say goodbye to snoozing and hello to productivity!

<iframe width="560" height="315" src="https://www.youtube.com/embed/kXXF7_j0hzw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Features

### 🎮 Mini-Games to Wake You Up 
*eepy* includes a variety of fun and challenging mini-games to stimulate your brain and get you moving:
- **Circle Tap**: Tap the circle as fast as you can.
- **Pong**: Play a quick round of the classic Pong game.
- **Slider Match**: Align the slider to match the target position.
- **Tap Counter**: Reach the required number of taps.
- **Wordle**: Solve a word puzzle in limited attempts.
- **Word Scramble**: Unscramble the letters to form the correct word.

### 🎨 Intuitive Design 
*eepy* features a user-friendly and visually appealing interface, making it simple to set up and use.

## How It Works
1. **Set an Alarm**: Choose your wake-up time in 30 min interval.
2. **Wake Up and Play**: When the alarm rings, complete a random mini-game to turn it off.
3. **Stay Awake**: By the time you've finished the games, you'll be ready to start your day.

## Installation

To install and run *eepy* on your iOS device:
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername eepy.git
   ```
2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device.

## Tech Stack
 *eepy* leverages the following technologies:
- **Language**: Swift
- **Framework**: SwiftUI
- **IDE**: Xcode
- **Version Control**: Git

## Development
 *eepy* is written in Swift and uses SwiftUI for its user interface. The app's modular design makes it easy to add or modify mini-games.

### Key Files
- **`ContentView.swift`**: The main entry point of the app.
- **`CompletionView.swift`**: Displays the completion message after finishing mini-games.
- **`MiniGame.swift`**: Handles the logic for loading and managing mini-games.
- Mini-Game Views:
  - **`CircleTapView.swift`**
  - **`PongView.swift`**
  - **`SliderMatchView.swift`**
  - **`TapCounterView.swift`**
  - **`WordleView.swift`**
  - **`WordScrambleView.swift`**

## Contribution

We welcome contributions to make *eepy* even better! To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to your fork and submit a pull request.

## Acknowledgements

- [Apple Developer Documentation](https://developer.apple.com/design/human-interface-guidelines/): For providing extensive resources on Swift and SwiftUI.
- [How to Make a Game Like Wordle in SwiftUI (Part One)](https://www.kodeco.com/31661263-how-to-make-a-game-like-wordle-in-swiftui)
- [Build a Fasting Timer App in SwiftUI](https://www.youtube.com/watch?v=pdYTtbOl9YQ)
- Stack Overflow Community: For helpful solutions and discussions.

---

Get ready to wake up like never before with *eepy*, the alarm clock that ensures you're wide awake and ready to conquer the day!
