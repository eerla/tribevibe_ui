import 'package:flutter/material.dart';

class AppColors {
  static const electricBlue = Color(0xFF1E90FF); // Techy energy for headers, primary buttons, links
  static const vibrantCoral = Color(0xFFFF6B6B); // CTAs, active states, highlights
  static const deepCharcoal = Color(0xFF2C2F33); // Text, nav, borders
  static const softWhite = Color(0xFFF5F6F5); // Backgrounds, light mode
  static const limeGreen = Color(0xFF32CD32); // Success, tags, hover

  // App-wide aliases for easy migration
  static const primary = electricBlue;
  static const secondary = vibrantCoral;
  static const accent = deepCharcoal;
  static const background = softWhite;
  static const card = softWhite;
  static const button = electricBlue;
  static const buttonText = Colors.white;
  static const icon = electricBlue;
  static const text = deepCharcoal;
  static const success = limeGreen;
}
