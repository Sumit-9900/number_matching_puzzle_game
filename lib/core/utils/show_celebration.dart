import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';
import 'package:provider/provider.dart';

void showCelebration(BuildContext context) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;
  final confettiController = ConfettiController(
    duration: const Duration(seconds: 3),
  );

  entry = OverlayEntry(
    builder: (_) => Positioned.fill(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Semi-transparent background (optional)
          Container(color: Colors.black.withOpacity(0.3)),

          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 20,
            shouldLoop: false,
            emissionFrequency: 0.05,
            gravity: 0.3,
          ),

          Text(
            "🎉 Congratulations! 🎉",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.highlightColor,
              shadows: [Shadow(color: Colors.black, blurRadius: 5)],
            ),
          ),
        ],
      ),
    ),
  );

  overlay.insert(entry);

  confettiController.play();

  Timer(const Duration(seconds: 5), () {
    confettiController.stop();
    entry.remove();
    confettiController.dispose();
    context.read<GameProvider>().resetToLevel1();
  });
}
