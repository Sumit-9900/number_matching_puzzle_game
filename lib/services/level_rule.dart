import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';

abstract interface class LevelRule {
  LevelConfig getLevelConfig(Difficulty difficulty);
}

class GridCompletionRule implements LevelRule {
  @override
  LevelConfig getLevelConfig(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return LevelConfig(
          difficulty: Difficulty.easy,
          gridSize: 5,
          initialFilledRows: 3,
          addRows: 0,
          targetScore: 25,
        );
      case Difficulty.medium:
        return LevelConfig(
          difficulty: Difficulty.medium,
          gridSize: 6,
          initialFilledRows: 4,
          addRows: 1,
          targetScore: 50,
        );
      case Difficulty.hard:
        return LevelConfig(
          difficulty: Difficulty.hard,
          gridSize: 7,
          initialFilledRows: 4,
          addRows: 2,
          targetScore: 90,
        );
    }
  }
}

class SubLevelRule implements LevelRule {
  @override
  LevelConfig getLevelConfig(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return LevelConfig(
          difficulty: Difficulty.easy,
          gridSize: 5,
          initialFilledRows: 3,
          addRows: 0,
          subLevel: 2,
        );
      case Difficulty.medium:
        return LevelConfig(
          difficulty: Difficulty.medium,
          gridSize: 6,
          initialFilledRows: 4,
          addRows: 1,
          subLevel: 3,
        );
      case Difficulty.hard:
        return LevelConfig(
          difficulty: Difficulty.hard,
          gridSize: 7,
          initialFilledRows: 4,
          addRows: 2,
          subLevel: 4,
        );
    }
  }
}

class XpLevelRule implements LevelRule {
  @override
  LevelConfig getLevelConfig(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return LevelConfig(
          difficulty: Difficulty.easy,
          gridSize: 5,
          initialFilledRows: 3,
          addRows: 0,
          xpRequired: 50,
        );
      case Difficulty.medium:
        return LevelConfig(
          difficulty: Difficulty.medium,
          gridSize: 6,
          initialFilledRows: 4,
          addRows: 1,
          xpRequired: 100,
        );
      case Difficulty.hard:
        return LevelConfig(
          difficulty: Difficulty.hard,
          gridSize: 7,
          initialFilledRows: 4,
          addRows: 2,
          xpRequired: 200,
        );
    }
  }
}
