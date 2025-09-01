// GameProvider: central state manager for gameplay lifecycle, grid, scoring, and timer.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/game_cell.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';
import 'package:number_matching_puzzle_game/services/audio_service.dart';
import 'package:number_matching_puzzle_game/services/level_service.dart';
import 'package:number_matching_puzzle_game/services/number_generator.dart';

class GameProvider extends ChangeNotifier {
  final LevelService _levelService = LevelService();
  final NumberGenerator _numberGenerator = NumberGenerator();
  final AudioService _audioService = AudioService();

  Difficulty _currentDifficulty = Difficulty.easy;
  LevelConfig? _levelConfig;
  List<GameCell> _cells = [];
  int _rowsAdded = 0;
  bool _canAddRow = false;
  int _score = 0;
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isGameRunning = false;
  int? _selectedIndex;
  final bool _isMatchingCellVisible = true;
  bool _isGameCompleted = false;

  // Getters
  Difficulty get currentDifficulty => _currentDifficulty;
  LevelConfig? get levelConfig => _levelConfig;
  List<GameCell> get cells => _cells;
  int get rowsAdded => _rowsAdded;
  bool get canAddRow => _canAddRow;
  int get score => _score;
  Duration get remainingTime => _remainingTime;
  bool get isGameRunning => _isGameRunning;
  int? get selectedIndex => _selectedIndex;
  bool get isMatchingCellVisible => _isMatchingCellVisible;
  bool get isGameCompleted => _isGameCompleted;

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
    _canAddRow = false; // Reset add row capability
    notifyListeners();
  }

  /// Change difficulty level and reset game state
  void changeDifficulty(Difficulty difficulty) {
    if (_currentDifficulty != difficulty) {
      _initializeLevel(difficulty);
    }
  }

  // Called when user presses "Add Row"
  void addRow() {
    if (_levelConfig == null) return;

    // If already reached max allowed rows → disable addRow
    if (_rowsAdded >= _levelConfig!.addRows) {
      _canAddRow = false; // ✅ disable button
      notifyListeners();
      return;
    }

    _audioService.playButtonClick();

    final newNumbers = _numberGenerator.generateAddRowNumbers(
      _levelConfig!,
      _cells.map((c) => c.number).toList(),
    );

    _cells.addAll(newNumbers.map((n) => GameCell(number: n)));
    _rowsAdded++;

    // Update canAddRow depending on how many rows left
    _canAddRow = _rowsAdded < _levelConfig!.addRows;

    notifyListeners();
  }

  // startGame: starts countdown timer and enables interactions.
  void startGame() {
    if (_isGameRunning) return;
    _isGameRunning = true;
    _isGameCompleted = false;
    _rowsAdded = 0;
    _remainingTime = _levelConfig!.timeLimit;
    _audioService.playButtonClick();

    _canAddRow = _levelConfig!.addRows > 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime -= const Duration(seconds: 1);
        if (_remainingTime.inSeconds == 9) {
          _audioService.playClockTickingSound();
        }
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

  // selectCell: handles selection/match flow and triggers per-cell error flash.
  void selectCell(int index) {
    if (index < 0 || index >= _cells.length) return;
    if (_cells[index].isMatched) return;

    if (_selectedIndex == null) {
      _selectedIndex = index;
      _cells[index].isHighlighted = true;
      _audioService.playButtonClick();
    } else {
      if (_selectedIndex == index) {
        _cells[index].isHighlighted = false;
        _selectedIndex = null;
        _audioService.playButtonClick();
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
          _audioService.playSuccessSound();
        } else {
          firstCell.isHighlighted = false;
          // Trigger per-cell error flash (auto-clears after delay)
          firstCell.showError = true;
          secondCell.showError = true;
          _audioService.playErrorSound();
          notifyListeners();

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

  // updateScore: adds points based on match rule (same or sum-to-10).
  void updateScore(int first, int second) {
    if (first + second == 10) {
      _score += 5;
    } else if (first == second) {
      _score += 3;
    }
    notifyListeners();
  }

  // resetGame: reinitialize current level state.
  void resetGame() {
    _audioService.playButtonClick();
    _isGameCompleted = false;
    _initializeLevel(_currentDifficulty);
    notifyListeners();
  }

  void resetToLevel1() {
    _isGameCompleted = false;
    _initializeLevel(Difficulty.easy);
    notifyListeners();
  }

  void _checkLevelCompletion() {
    if (_score >= (_levelConfig?.targetScore ?? 0)) {
      // Advance to next level
      _audioService.playQuickWinSound();
      if (_currentDifficulty == Difficulty.easy) {
        _initializeLevel(Difficulty.medium);
      } else if (_currentDifficulty == Difficulty.medium) {
        _initializeLevel(Difficulty.hard);
      } else {
        // Game completed 🎉
        _isGameRunning = false;
        _timer?.cancel();
        _isGameCompleted = true;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioService.dispose();
    super.dispose();
  }
}
