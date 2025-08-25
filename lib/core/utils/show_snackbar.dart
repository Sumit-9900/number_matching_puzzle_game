import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';

void showSnakbar(
  BuildContext context, {
  required String title,
  Color backgroundColor = Colors.red,
}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
}
