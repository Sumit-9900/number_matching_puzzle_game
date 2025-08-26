import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';

class LevelConfig {
  final Difficulty difficulty;
  final int gridSize;
  final Duration timeLimit;
  final int initialFilledRows;
  final int targetScore;

  LevelConfig({
    required this.difficulty,
    required this.gridSize,
    this.timeLimit = const Duration(minutes: 2),
    required this.initialFilledRows,
    required this.targetScore,
  });
}
