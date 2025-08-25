import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';
import 'package:number_matching_puzzle_game/core/utils/show_snackbar.dart';
import 'package:number_matching_puzzle_game/models/game_cell.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';

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
    Color borderColor = AppColors.deepPurpleColor;
    if (cell.isHighlighted) borderColor = AppColors.highlightColor;
    // if (_showError) borderColor = Colors.red;

    return GestureDetector(
      onTap: cell.number == 0
          ? null
          : gameProvider.isGameRunning
          ? () => gameProvider.selectCell(index)
          : () => showSnakbar(
              context,
              title: 'Please start the game first!',
            ), // disable tap if empty
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: cell.isHighlighted ? 2.0 : 1.0,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: cell.number == 0
            ? const SizedBox.shrink() // 👈 just an empty box
            : AnimatedOpacity(
                opacity: cell.isMatched ? 0.3 : 1.0,
                duration: const Duration(milliseconds: 800),
                child: Text(
                  cell.number.toString(),
                  style: GoogleFonts.orbitron(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
      ),
    );
  }
}
