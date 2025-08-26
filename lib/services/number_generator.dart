import 'dart:math';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/models/level_config.dart';

// NumberGenerator: creates initial grid numbers and utilities for row additions.
class NumberGenerator {
  static final NumberGenerator _instance = NumberGenerator._internal();
  factory NumberGenerator() => _instance;
  NumberGenerator._internal();

  static final Random _random = Random();

  /// Generate initial numbers for the grid based on difficulty level
  List<int> generateInitialNumbers(LevelConfig config) {
    int totalCells = config.initialFilledRows * config.gridSize;

    List<int> numbers;
    switch (config.difficulty) {
      case Difficulty.easy:
        numbers = _generateNumbers(totalCells, obviousPairs: 0.5, fives: 0.2);
        break;
      case Difficulty.medium:
        numbers = _generateNumbers(totalCells, obviousPairs: 0.3, fives: 0.1);
        break;
      case Difficulty.hard:
        numbers = _generateNumbers(totalCells, obviousPairs: 0.15, fives: 0.05);
        break;
    }

    numbers.shuffle(_random);
    return numbers;
  }

  /// Generate numbers for a new row when "Add Row" button is pressed
  List<int> generateAddRowNumbers(LevelConfig config, List<int> existing) {
    int rowLength = config.gridSize;
    List<int> row = [];

    for (int i = 0; i < rowLength; i++) {
      double helpfulChance = switch (config.difficulty) {
        Difficulty.easy => 0.7,
        Difficulty.medium => 0.5,
        Difficulty.hard => 0.3,
      };

      if (_random.nextDouble() < helpfulChance) {
        row.add(_findHelpfulNumber(existing));
      } else {
        row.add(_random.nextInt(9) + 1);
      }
    }

    return row;
  }

  // ========== CORE GENERATION LOGIC ==========

  // _generateNumbers(totalCells, obviousPairs: 0.5, fives: 0.2);
  List<int> _generateNumbers(
    int count, {
    double obviousPairs = 0.3,
    double fives = 0.1,
  }) {
    List<int> numbers = [];

    // Obvious sum=10 pairs
    int pairsCount = (count * obviousPairs).round() ~/ 2;
    List<List<int>> pairs = [
      [1, 9],
      [2, 8],
      [3, 7],
      [4, 6],
    ];
    for (int i = 0; i < pairsCount; i++) {
      numbers.addAll(pairs[i % pairs.length]);
    }

    // Some 5s (self match)
    int fivesCount = (count * fives).round();
    numbers.addAll(List.filled(fivesCount, 5));

    // Fill the rest with random numbers (weighted to mid values)
    while (numbers.length < count) {
      numbers.add(
        _weightedRandom(
          [1, 2, 3, 4, 5, 6, 7, 8, 9],
          [2, 2, 3, 4, 5, 4, 3, 2, 2],
        ),
      );
    }

    return _adjustToCount(numbers, count);
  }

  int _findHelpfulNumber(List<int> existing) {
    Map<int, int> scores = {};
    for (int candidate = 1; candidate <= 9; candidate++) {
      int score = 0;
      for (var n in existing) {
        if (candidate + n == 10) score += 3;
        if (candidate == n) score += 2;
      }
      scores[candidate] = score;
    }
    return scores.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  int _weightedRandom(List<int> numbers, List<int> weights) {
    int total = weights.reduce((a, b) => a + b);
    int pick = _random.nextInt(total);
    int current = 0;
    for (int i = 0; i < numbers.length; i++) {
      current += weights[i];
      if (pick < current) return numbers[i];
    }
    return numbers.first;
  }

  List<int> _adjustToCount(List<int> numbers, int target) {
    while (numbers.length > target) {
      numbers.removeLast();
    }
    while (numbers.length < target) {
      numbers.add(_random.nextInt(9) + 1);
    }
    return numbers;
  }
}
