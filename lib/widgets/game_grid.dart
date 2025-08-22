import 'package:flutter/material.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.deepPurpleColor),
      ),
      child: const SizedBox.shrink(),
    );
  }
}
