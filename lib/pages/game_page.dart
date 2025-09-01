import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_matching_puzzle_game/core/enums/difficulty.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';
import 'package:number_matching_puzzle_game/core/utils/show_celebration.dart';
import 'package:number_matching_puzzle_game/models/game_cell.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';
import 'package:number_matching_puzzle_game/widgets/game_grid.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
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
        final addRowCondition = isGameStarted && gameProvider.canAddRow;

        if (gameProvider.isGameCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showCelebration(context);
          });
        }

        return Scaffold(
          // Background gradient sits below content and remains visible through SafeArea.
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.scaffoldBgColor1,
                      AppColors.scaffoldBgColor2,
                    ],
                  ),
                ),
              ),

              // Foreground content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      // Scrollable main section
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),

                              // Difficulty + Timer
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    difficultyString(currentDifficulty),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: AppColors.whiteColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(CupertinoIcons.stopwatch_fill),
                                      const SizedBox(width: 5),
                                      Text(
                                        remainingTimeInMinutes,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
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
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  color: Colors.amber,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Game Grid (non-scrollable inside scroller)
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          currentLevelConfig.gridSize,
                                    ),
                                itemCount:
                                    currentLevelConfig.gridSize *
                                    currentLevelConfig.gridSize,
                                itemBuilder: (context, index) {
                                  final hasNumber = index < cells.length;
                                  final cell = hasNumber
                                      ? cells[index]
                                      : GameCell(number: 0);

                                  return GameGrid(
                                    index: index,
                                    cell: cell,
                                    gameProvider: gameProvider,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Fixed bottom controls
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isGameStarted
                                        ? AppColors.greyColor
                                        : AppColors.deepPurpleColor,
                                    foregroundColor: isGameStarted
                                        ? const Color.fromARGB(
                                            108,
                                            255,
                                            255,
                                            255,
                                          )
                                        : AppColors.whiteColor,
                                  ),
                                  onPressed: isGameStarted
                                      ? null
                                      : () => gameProvider.startGame(),
                                  child: const Text('Start'),
                                ),
                                ElevatedButton(
                                  onPressed: () => gameProvider.resetGame(),
                                  child: const Text('Reset'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Add Row Button
                            GestureDetector(
                              onTap: addRowCondition
                                  ? () => gameProvider.addRow()
                                  : null,
                              child: CircleAvatar(
                                backgroundColor: addRowCondition
                                    ? AppColors.deepPurpleColor
                                    : AppColors.greyColor,
                                radius: 30,
                                child: Icon(
                                  Icons.add,
                                  color: addRowCondition
                                      ? AppColors.whiteColor
                                      : const Color.fromARGB(
                                          108,
                                          255,
                                          255,
                                          255,
                                        ),
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
