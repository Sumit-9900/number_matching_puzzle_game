import 'package:flutter/material.dart';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';
import 'package:number_matching_puzzle_game/services/level_service.dart';

class GameProvider extends ChangeNotifier {
  final LevelService _levelService = LevelService();

  Difficulty _currentDifficulty = Difficulty.easy;
  LevelConfig? _levelConfig;

  // Getters
  Difficulty get currentDifficulty => _currentDifficulty;
  LevelConfig? get levelConfig => _levelConfig;

  GameProvider() {
    _initializeWithEasyDifficulty();
  }

  void _initializeWithEasyDifficulty() {
    _currentDifficulty = _levelService.getDefaultDifficulty();
    _levelConfig = _levelService.getLevelConfig(_currentDifficulty);
  }
}
