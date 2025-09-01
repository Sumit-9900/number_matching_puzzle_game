import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';
import 'package:number_matching_puzzle_game/services/level_rule.dart';

class LevelService {
  final LevelRule levelRule;
  LevelService({LevelRule? rule}) : levelRule = rule ?? GridCompletionRule();

  LevelConfig getLevelConfig(Difficulty difficulty) =>
      levelRule.getLevelConfig(difficulty);

  Difficulty getDefaultDifficulty() => Difficulty.easy;
}
