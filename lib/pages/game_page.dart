import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';
import 'package:number_matching_puzzle_game/models/game_cell.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';
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
              final cells = gameProvider.cells;
              final isGameStarted = gameProvider.isGameRunning;
              final remainingTime = gameProvider.remainingTime;
              final remainingTimeInMinutes =
                  '${remainingTime.inMinutes}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}';
              final backgroundColorOfTimeLeft = remainingTime.inSeconds < 30
                  ? Colors.red
                  : remainingTime.inSeconds < 60
                  ? Colors.orange
                  : Colors.green;
              final addRowCondition =
                  isGameStarted &&
                  (gameProvider.rowsAdded <
                      (currentLevelConfig!.gridSize -
                          currentLevelConfig.initialFilledRows));

              return Column(
                children: [
                  const SizedBox(height: 30),

                  // Difficulty + Timer
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
                      Row(
                        children: [
                          Icon(CupertinoIcons.stopwatch_fill),
                          const SizedBox(width: 5),
                          Text(
                            // show live remaining time from provider
                            remainingTimeInMinutes,
                            style: GoogleFonts.poppins(
                              color: isGameStarted
                                  ? backgroundColorOfTimeLeft
                                  : AppColors.whiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Score
                  Text(
                    'Score: ${gameProvider.score}/${currentLevelConfig!.targetScore}',
                    style: GoogleFonts.orbitron(
                      color: Colors.amber,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Game Grid
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: currentLevelConfig.gridSize,
                      ),
                      itemCount:
                          currentLevelConfig.gridSize *
                          currentLevelConfig.gridSize,
                      itemBuilder: (context, index) {
                        final hasNumber = index < cells.length;
                        final cell = hasNumber
                            ? cells[index]
                            : GameCell(number: 0); // 👈 empty placeholder cell

                        return GameGrid(
                          index: index,
                          cell: cell,
                          gameProvider: gameProvider,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isGameStarted
                              ? AppColors.greyColor
                              : AppColors.deepPurpleColor,
                          foregroundColor: isGameStarted
                              ? const Color.fromARGB(108, 255, 255, 255)
                              : AppColors.whiteColor,
                        ),
                        onPressed: isGameStarted
                            ? () {}
                            : () => gameProvider.startGame(),
                        child: Text('Start'),
                      ),
                      ElevatedButton(
                        onPressed: () => gameProvider.resetGame(),
                        child: Text('Reset'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Add Row Button
                  GestureDetector(
                    onTap: addRowCondition
                        ? () => gameProvider.addRow()
                        : () {},
                    child: CircleAvatar(
                      backgroundColor: addRowCondition
                          ? AppColors.deepPurpleColor
                          : AppColors.greyColor,
                      radius: 30,
                      child: Icon(
                        Icons.add,
                        color: addRowCondition
                            ? AppColors.whiteColor
                            : const Color.fromARGB(108, 255, 255, 255),
                        size: 40,
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
