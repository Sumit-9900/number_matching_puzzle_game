import 'dart:async';
import 'package:flutter/material.dart';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/game_cell.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';
import 'package:number_matching_puzzle_game/services/level_service.dart';
import 'package:number_matching_puzzle_game/services/number_generator.dart';

class GameProvider extends ChangeNotifier {
  final LevelService _levelService = LevelService();
  final NumberGenerator _numberGenerator = NumberGenerator();

  Difficulty _currentDifficulty = Difficulty.easy;
  LevelConfig? _levelConfig;
  List<GameCell> _cells = [];
  int _rowsAdded = 0;
  int _score = 0;
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isGameRunning = false;
  int? _selectedIndex;
  final bool _isMatchingCellVisible = true;

  // Getters
  Difficulty get currentDifficulty => _currentDifficulty;
  LevelConfig? get levelConfig => _levelConfig;
  List<GameCell> get cells => _cells;
  int get rowsAdded => _rowsAdded;
  int get score => _score;
  Duration get remainingTime => _remainingTime;
  bool get isGameRunning => _isGameRunning;
  int? get selectedIndex => _selectedIndex;
  bool get isMatchingCellVisible => _isMatchingCellVisible;

  GameProvider() {
    _initializeLevel(Difficulty.easy);
  }

  void _initializeLevel(Difficulty difficulty) {
    _currentDifficulty = difficulty;
    _levelConfig = _levelService.getLevelConfig(difficulty);

    final numbers = _numberGenerator.generateInitialNumbers(_levelConfig!);
    _cells = numbers.map((n) => GameCell(number: n)).toList();

    _rowsAdded = 0;
    _score = 0;
    _remainingTime = _levelConfig!.timeLimit;
    _isGameRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  // Called when user presses "Add Row"
  void addRow() {
    if (_levelConfig == null) return;
    if (_rowsAdded >=
        (_levelConfig!.gridSize - _levelConfig!.initialFilledRows)) {
      return;
    }

    final newNumbers = _numberGenerator.generateAddRowNumbers(
      _levelConfig!, // uses gridSize internally
      _cells.map((c) => c.number).toList(), // existing numbers on the board
    );

    _cells.addAll(newNumbers.map((n) => GameCell(number: n)));
    _rowsAdded++;
    notifyListeners();
  }

  // Called when user presses "Start"
  void startGame() {
    if (_isGameRunning) return;
    _isGameRunning = true;
    _remainingTime = _levelConfig!.timeLimit;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime -= const Duration(seconds: 1);
        notifyListeners();
      } else {
        timer.cancel();
        _isGameRunning = false;
        notifyListeners();
      }
      _checkLevelCompletion();
    });

    notifyListeners();
  }

  void selectCell(int index) {
    if (index < 0 || index >= _cells.length) return;
    if (_cells[index].isMatched) return;

    if (_selectedIndex == null) {
      _selectedIndex = index;
      _cells[index].isHighlighted = true;
    } else {
      if (_selectedIndex == index) {
        _cells[index].isHighlighted = false;
        _selectedIndex = null;
      } else {
        final firstIndex = _selectedIndex;
        final secondIndex = index;

        final firstCell = _cells[firstIndex!];
        final secondCell = _cells[secondIndex];

        if (_isValidMatch(firstIndex, secondIndex)) {
          firstCell.isMatched = true;
          secondCell.isMatched = true;
          firstCell.isHighlighted = false;
          updateScore(firstCell.number, secondCell.number);
        } else {
          firstCell.isHighlighted = false;
          firstCell.showError = true;
          secondCell.showError = true;
          notifyListeners();

          // clear error flags after 1s so it can re-trigger next time
          Future.delayed(const Duration(seconds: 1), () {
            if (!hasListeners) return;
            firstCell.showError = false;
            secondCell.showError = false;
            notifyListeners();
          });
        }
        _selectedIndex = null;
      }
    }
    notifyListeners();
  }

  bool _isValidMatch(int aIndex, int bIndex) {
    final firstCell = _cells[aIndex];
    final secondCell = _cells[bIndex];
    return (firstCell.number == secondCell.number) ||
        (firstCell.number + secondCell.number == 10);
  }

  // Called when user presses "Reset"
  void resetGame() {
    _initializeLevel(_currentDifficulty);
  }

  // Update score (e.g., when matches are made in puzzle logic)
  void updateScore(int first, int second) {
    if (first + second == 10) {
      _score += 5;
    } else if (first == second) {
      _score += 3;
    }
    notifyListeners();
  }

  void _checkLevelCompletion() {
    if (_score >= _levelConfig!.targetScore) {
      // Advance to next level
      if (_currentDifficulty == Difficulty.easy) {
        _initializeLevel(Difficulty.medium);
      } else if (_currentDifficulty == Difficulty.medium) {
        _initializeLevel(Difficulty.hard);
      } else {
        // Game completed 🎉
        _isGameRunning = false;
        _timer?.cancel();
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
