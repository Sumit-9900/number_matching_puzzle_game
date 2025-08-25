import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_matching_puzzle_game/core/theme/app_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.deepPurpleColor),
        foregroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    ),
  );
}
