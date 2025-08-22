# Number Matching Puzzle Game

A Flutter-based number matching puzzle game with multiple difficulty levels.

## Features

- **Multiple Difficulty Levels**: Easy, Medium, and Hard
- **Easy Difficulty by Default**: The app automatically initializes with Easy difficulty
- **Configurable Game Parameters**: Each difficulty has different grid sizes, time limits, and target scores
- **Provider State Management**: Uses Provider pattern for efficient state management

## How to Initialize with Easy Difficulty

The app is designed to automatically start with Easy difficulty. Here's how it works:

### 1. Default Initialization
The `GameProvider` constructor automatically calls `_initializeWithEasyDifficulty()` which:
- Sets the current difficulty to `Difficulty.easy`
- Loads the easy difficulty configuration from `LevelService`
- Sets up the initial game state

### 2. Easy Difficulty Configuration
Easy difficulty includes:
- **Grid Size**: 4x4
- **Time Limit**: 3 minutes
- **Initial Filled Rows**: 2
- **Max Add Rows**: 1
- **Target Score**: 100
- **Target Match Percentage**: 70%

### 3. Changing Difficulty
Users can change the difficulty level through the UI:
- Tap "Change Difficulty" button
- Select from Easy, Medium, or Hard
- The game configuration updates automatically

## Project Structure

```
lib/
├── core/
│   ├── enums/
│   │   └── difficulty.dart          # Difficulty enum definition
│   └── theme/
│       └── app_colors.dart          # App color scheme
├── models/
│   └── level_config.dart            # Level configuration model
├── services/
│   └── level_service.dart           # Service for managing difficulty levels
├── viewmodel/
│   └── game_provider.dart           # Game state management with Provider
├── pages/
│   └── game_page.dart               # Main game UI
└── main.dart                        # App entry point with Provider setup
```

## Running the App

1. Ensure Flutter is installed and configured
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app
4. The app will automatically initialize with Easy difficulty

## Dependencies

- `provider: ^6.1.5+1` - State management
- `google_fonts: ^6.3.0` - Typography
- `cupertino_icons: ^1.0.8` - Icons

## Development

To modify the default difficulty or add new difficulty levels:

1. Update `LevelService.getDefaultDifficulty()` to return a different difficulty
2. Modify `LevelService.getLevelConfig()` to adjust difficulty parameters
3. The UI will automatically reflect the changes through the Provider pattern
