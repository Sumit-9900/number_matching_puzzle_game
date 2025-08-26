// LevelService: returns per-difficulty LevelConfig and default difficulty.
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';

class LevelService {
  static final LevelService _instance = LevelService._internal();
  factory LevelService() => _instance;
  LevelService._internal();

  LevelConfig getLevelConfig(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return LevelConfig(
          difficulty: Difficulty.easy,
          gridSize: 5,
          initialFilledRows: 3,
          targetScore: 25,
        );
      case Difficulty.medium:
        return LevelConfig(
          difficulty: Difficulty.medium,
          gridSize: 6,
          initialFilledRows: 4,
          targetScore: 50,
        );
      case Difficulty.hard:
        return LevelConfig(
          difficulty: Difficulty.hard,
          gridSize: 7,
          initialFilledRows: 4,
          targetScore: 100,
        );
    }
  }

  Difficulty getDefaultDifficulty() {
    return Difficulty.easy;
  }
}
