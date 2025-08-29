import 'package:flutter/material.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';
import 'package:number_matching_puzzle_game/core/utils/show_snackbar.dart';
import 'package:number_matching_puzzle_game/models/game_cell.dart';
import 'package:number_matching_puzzle_game/services/audio_service.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';

// Renders a single grid cell with highlight, match fade, and error flash visuals.
class GameGrid extends StatelessWidget {
  final int index;
  final GameCell cell;
  final GameProvider gameProvider;

  const GameGrid({
    super.key,
    required this.index,
    required this.cell,
    required this.gameProvider,
  });

  @override
  Widget build(BuildContext context) {
    final AudioService audioService = AudioService();
    Color baseBorderColor = AppColors.deepPurpleColor;
    if (cell.isHighlighted) baseBorderColor = AppColors.highlightColor;

    return GestureDetector(
      // Disable taps on empty cells or when game hasn't started.
      onTap: cell.number == 0
          ? null
          : gameProvider.isGameRunning
          ? () => gameProvider.selectCell(index)
          : () {
              audioService.playErrorSound();
              showSnakbar(context, title: 'Please start the game first!');
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: cell.isHighlighted ? 2.0 : 1.0,
            color: cell.showError ? Colors.red : baseBorderColor,
          ),
          color: cell.showError
              ? Colors.red.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: cell.showError
              ? [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.35),
                    blurRadius: 8,
                    spreadRadius: 1.5,
                  ),
                ]
              : null,
        ),
        child: cell.number == 0
            ? const SizedBox.shrink()
            : AnimatedOpacity(
                opacity: cell.isMatched ? 0.3 : 1.0,
                duration: const Duration(milliseconds: 800),
                child: Text(
                  cell.number.toString(),
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: cell.showError
                        ? Colors.amber.withOpacity(0.3)
                        : Colors.amber,
                  ),
                ),
              ),
      ),
    );
  }
}
