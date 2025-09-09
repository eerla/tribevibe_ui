import 'package:flutter/material.dart';

class AppColors {
  // UI Color Guide: Light Theme
  static const mainBackground = Color(0xFFFAFAFA); // Main Background
  static const cardBackground = Color(0xFFFFFFFF); // Card Background
  static const secondaryCard = Color(0xFFF5F5F5); // Secondary Card
  static const primaryText = Color(0xFF2E2E2E); // Primary Text
  static const secondaryText = Color(0xFF6B6B6B); // Secondary Text
  static const accentText = Color(0xFFFFB13B); // Accent Text (Golden Orange)
  static const primary = Color(0xFFFFB13B); // Brand/Primary CTA (Golden Orange)
  static const secondary = Color(0xFFFAFAFA); // For backgrounds, etc.

  // UI Color Guide: Dark Theme
  static const darkMainBackground = Color(0xFF181818); // Main Background
  static const darkCardBackground = Color(0xFF232323); // Card Background
  static const darkSecondaryCard = Color(0xFF2E2E2E); // Secondary Card
  static const darkPrimaryText = Color(0xFFF5F5F5); // Primary Text
  static const darkSecondaryText = Color(0xFFBDBDBD); // Secondary Text
  static const darkAccentText = Color(0xFFFFB13B); // Accent Text (Golden Orange)
  static const darkPrimary = Color(0xFFFFB13B); // Brand/Primary CTA (Golden Orange)
  static const darkSecondary = Color(0xFF181818); // For backgrounds, etc.

  // UI aliases
  static const background = mainBackground;
  static const card = cardBackground;
  static const button = primary;
  static const buttonText = Color(0xFFFFFFFF);
  static const icon = primary;

  // Dark theme aliases
  static const darkBackground = darkMainBackground;
  static const darkCard = darkCardBackground;
  static const darkButton = darkPrimary;
  static const darkButtonText = Color(0xFFFFFFFF);
  static const darkIcon = darkPrimary;
}


// class AppColors {
//   // Brand
//   static const Color primary = Color(0xFFFFB13B);
//   static const Color accentText = Color(0xFFFFB13B);

//   // Light theme
//   static const Color lightBackground = Color(0xFFFAFAFA);
//   static const Color lightCard = Color(0xFFFFFFFF);
//   static const Color lightSecondaryCard = Color(0xFFF5F5F5);
//   static const Color lightTextPrimary = Color(0xFF2E2E2E);
//   static const Color lightTextSecondary = Color(0xFF6B6B6B);

//   // UI aliases
//   static const Color background = lightBackground;
//   static const Color card = lightCard;
//   static const Color button = primary;
//   static const Color buttonText = Color(0xFFFFFFFF);
//   static const Color icon = primary;
// }
