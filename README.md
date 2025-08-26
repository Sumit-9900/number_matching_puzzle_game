# Number Matching Puzzle Game

A Flutter-based puzzle game where players match numbers to score points. Match identical numbers or pairs that sum to 10 to progress through increasingly challenging levels.

## 🎮 Game Overview

The Number Matching Puzzle Game is an engaging puzzle experience that tests your pattern recognition and quick thinking skills. Players must match numbers on a grid by selecting pairs that are either identical or sum to 10, all while racing against the clock.

## 🚀 Features

- **Multiple Difficulty Levels**: Easy, Medium, and Hard with progressively challenging configurations
- **Dynamic Scoring System**: Different points for identical matches (3 points) vs. sum-to-10 matches (5 points)
- **Real-time Timer**: Countdown timer with color-coded urgency indicators
- **Visual Feedback**: Red flash animation for incorrect selections
- **Progress Tracking**: Score display and level completion detection
- **Responsive Design**: Beautiful UI with smooth animations and modern styling
- **Add Row Mechanic**: Strategic gameplay element to add new rows during play

## 🎯 Game Rules

### Basic Mechanics
1. **Start the Game**: Tap "Start" to begin the timer and enable cell selection
2. **Select Cells**: Tap on numbered cells to select them
3. **Make Matches**: Select two cells that either:
   - Have identical numbers (e.g., 5 and 5)
   - Sum to 10 (e.g., 3 and 7, 4 and 6)
4. **Score Points**: 
   - Identical matches: 3 points
   - Sum-to-10 matches: 5 points
5. **Avoid Errors**: Incorrect selections trigger a red flash animation on the unmatched cells

### Strategic Elements
- **Add Row**: Use the "+" button to add new rows when available (limited by difficulty)
- **Time Management**: Complete the level before time runs out
- **Score Targets**: Reach the target score to advance to the next level

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/
│   ├── enums/
│   │   └── difficulty.dart          # Difficulty level definitions
│   ├── theme/
│   │   ├── app_colors.dart          # Color scheme definitions
│   │   └── app_theme.dart           # App-wide theme configuration
│   └── utils/
│       └── show_snackbar.dart       # Utility for displaying messages
├── models/
│   ├── game_cell.dart               # Individual cell data model
│   └── level_config.dart            # Level configuration parameters
├── services/
│   ├── level_service.dart           # Difficulty level management
│   └── number_generator.dart        # Random number generation for grids
├── viewmodel/
│   └── game_provider.dart           # Game state management with Provider
├── widgets/
│   └── game_grid.dart               # Individual grid cell widget
├── pages/
│   └── game_page.dart               # Main game interface
└── main.dart                        # App entry point
```

### Key Components

#### State Management
- **Provider Pattern**: Uses `ChangeNotifierProvider` for reactive state management
- **GameProvider**: Central state manager handling game logic, scoring, and UI updates
- **Reactive UI**: Widgets automatically update when game state changes

#### Game Logic
- **Cell Selection**: Two-phase selection system with visual highlighting
- **Match Validation**: Checks for identical numbers or sum-to-10 pairs
- **Error Handling**: Per-cell error states with visual feedback
- **Timer Management**: Real-time countdown with automatic game completion

#### UI/UX Design
- **Dark Theme**: Modern dark interface with gradient backgrounds
- **Smooth Animations**: Animated containers, opacity transitions, and flash effects
- **Visual Feedback**: Color-coded elements for game state and urgency

## 🎚️ Difficulty Levels

### Easy (Level 1)
- **Grid Size**: 5×5
- **Initial Filled Rows**: 3
- **Target Score**: 25
- **Time Limit**: 2 minutes

### Medium (Level 2)
- **Grid Size**: 6×6
- **Initial Filled Rows**: 4
- **Target Score**: 50
- **Time Limit**: 2 minutes

### Hard (Level 3)
- **Grid Size**: 7×7
- **Initial Filled Rows**: 4
- **Target Score**: 100
- **Time Limit**: 2 minutes

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Sumit-9900/number_matching_puzzle_game
   cd number_matching_puzzle_game
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5+1        # State management
  google_fonts: ^6.3.0      # Typography
  cupertino_icons: ^1.0.8   # Icons
  confetti: ^0.8.0          # Celebration Animation
```

## 🐛 Troubleshooting

### Common Issues

1. **App Won't Start**
   - Ensure Flutter SDK is properly installed
   - Run `flutter doctor` to check for issues
   - Clear cache with `flutter clean && flutter pub get`

2. **Animation Issues**
   - Check if device supports the animation features
   - Verify animation controllers are properly disposed

3. **Performance Issues**
   - Reduce animation complexity on lower-end devices
   - Optimize grid rendering for larger grid sizes

## Conclusion

Enjoy a focused, fast-paced challenge—scan smart, match efficiently, and beat the clock. Have fun!
