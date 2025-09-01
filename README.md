# Number Matching Puzzle Game

A Flutter puzzle game where players match numbers to score points. Match identical numbers or pairs that sum to 10 to progress through increasingly challenging levels.

## 🎮 Game Overview

Number Matching Puzzle Game tests your pattern recognition and quick thinking. Match numbers on a grid by selecting pairs that are either identical or sum to 10, racing against the clock.

## 🚀 Features

- Multiple difficulty levels: Easy, Medium, Hard
- Dynamic scoring: 3 points for identical matches, 5 points for sum-to-10 matches
- Real-time timer with urgency indicators and ticking sound
- Audio feedback: click, success, error, quick-win sounds
- Visual feedback: red flash animation for incorrect selections
- Progress tracking: score display, level completion celebration
- Responsive design: smooth animations, modern UI
- Add row mechanic for strategic gameplay

## 🎯 Game Rules

### Basic Mechanics
1. Tap "Start" to begin the timer and enable cell selection
2. Tap numbered cells to select them
3. Select two cells that either:
   - Have identical numbers
   - Sum to 10
4. Score points:
   - Identical matches: 3 points
   - Sum-to-10 matches: 5 points
5. Incorrect selections trigger a red flash and error sound

### Strategic Elements
- Add Row: Use the "+" button to add new rows (limited by difficulty)
- Time Management: Complete the level before time runs out; ticking sound in last 9 seconds
- Score Targets: Reach the target score to advance

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/
│   ├── enums/
│   │   └── difficulty.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   └── utils/
│       └── show_snackbar.dart
├── models/
│   ├── game_cell.dart
│   └── level_config.dart
├── services/
│   ├── level_service.dart
│   ├── number_generator.dart
│   ├── audio_service.dart
│   └── level_rule.dart
├── viewmodel/
│   └── game_provider.dart
├── widgets/
│   └── game_grid.dart
├── pages/
│   └── game_page.dart
└── main.dart
```

### Key Components

#### State Management
- Provider pattern with `ChangeNotifierProvider`
- `GameProvider`: handles game logic, scoring, timer, audio

#### Game Logic
- Cell selection: two-phase selection with highlighting
- Match validation: identical or sum-to-10 pairs
- Error handling: per-cell error states, visual/audio feedback
- Timer: countdown, ticking audio, celebration on completion

#### UI/UX Design
- Dark theme, gradient backgrounds
- Smooth animations, opacity transitions, flash effects
- Color-coded elements for game state and urgency

## 🎚️ Difficulty Levels

- **Easy**: 5×5 grid, 3 filled rows, target 25, 2 min
- **Medium**: 6×6 grid, 4 filled rows, target 50, 2 min
- **Hard**: 7×7 grid, 4 filled rows, target 90, 2 min

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. Clone the repository
```bash
   git clone https://github.com/Sumit-9900/number_matching_puzzle_game
   cd number_matching_puzzle_game
```
2. Install dependencies
```bash
   flutter pub get
```
3. Run the application
```bash
   flutter run
```


## 🎥 Gameplay Demo

Watch a short gameplay demo: [Gameplay Recording](https://www.loom.com/share/285971fcf1114330a9fc71119cfb7da5)

## Conclusion

Enjoy a fast-paced challenge—scan smart, match efficiently, and beat the clock!
