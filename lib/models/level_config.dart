import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';

class LevelConfig {
  final Difficulty difficulty;
  final int gridSize;
  final Duration timeLimit;
  final int initialFilledRows;
  final int addRows;
  final int? targetScore; // specific for grid completion game
  final int? subLevel; // specific for sub level game
  final int? xpRequired; // specific for xp level game

  LevelConfig({
    required this.difficulty,
    required this.gridSize,
    this.timeLimit = const Duration(minutes: 2),
    required this.initialFilledRows,
    required this.addRows,
    this.targetScore,
    this.subLevel,
    this.xpRequired,
  });
}
