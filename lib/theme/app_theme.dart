import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.background,
          surface: AppColors.card,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: AppColors.primaryText,
          onSurface: AppColors.primaryText,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        cardColor: AppColors.card,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.inter(
            color: AppColors.primaryText,
            fontSize: 16,
          ),
          bodyMedium: GoogleFonts.inter(
            color: AppColors.primaryText,
            fontSize: 14,
          ),
          titleLarge: GoogleFonts.poppins(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headlineMedium: GoogleFonts.poppins(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          headlineSmall: GoogleFonts.poppins(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      );
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimary,
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      background: AppColors.darkBackground,
      surface: AppColors.darkCard,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onBackground: AppColors.darkPrimaryText,
      onSurface: AppColors.darkPrimaryText,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    cardColor: AppColors.darkCard,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        color: AppColors.darkPrimaryText,
        fontSize: 16,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppColors.darkSecondaryText,
        fontSize: 14,
      ),
      titleLarge: GoogleFonts.poppins(
        color: AppColors.darkPrimaryText,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: AppColors.darkPrimaryText,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: AppColors.darkPrimaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.darkPrimary.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.darkPrimary, width: 2),
      ),
    ),
  );
}
