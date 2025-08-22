import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';
import 'package:number_matching_puzzle_game/widgets/game_button.dart';
import 'package:number_matching_puzzle_game/widgets/game_grid.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.scaffoldBgColor1, AppColors.scaffoldBgColor2],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<GameProvider>(
            builder: (context, gameProvider, child) {
              final currentDifficulty = gameProvider.currentDifficulty;
              final currentLevelConfig = gameProvider.levelConfig;
              return Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        difficultyString(currentDifficulty),
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        '${currentLevelConfig!.timeLimit.inMinutes} : ${(currentLevelConfig.timeLimit.inSeconds % 60).toString().padLeft(2, '0')} min',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Score: 0/${currentLevelConfig.targetScore}',
                    style: GoogleFonts.orbitron(
                      color: Colors.amber,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: currentLevelConfig.gridSize,
                    ),
                    itemCount:
                        currentLevelConfig.gridSize *
                        currentLevelConfig.gridSize,
                    itemBuilder: (context, index) {
                      return GameGrid();
                    },
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GameButton(text: 'Start', onPressed: () {}),
                      GameButton(text: 'Reset', onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: AppColors.deepPurpleColor,
                      radius: 30,
                      child: Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
