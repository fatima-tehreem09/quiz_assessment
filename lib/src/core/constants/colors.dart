import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryPurple = Color(0xFFAB3CFC);
  static const Color primaryBlueViolet = Color(0xFF7E6DF3);

  static const Color secondaryDarkPurple = Color(0xFF533B7C);
  static const Color secondaryMutedPurple = Color(0xFF7C589A);
  static const Color secondaryLightPurple = Color(0xFF9F8CCA);

  static const Color neutralDark = Color(0xFF3E394C);

  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8F9FA);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF2D2D2D);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFE0E0E0);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  static const List<Color> primaryGradient = [
    primaryPurple,
    primaryBlueViolet,
  ];

  static const List<Color> secondaryGradient = [
    secondaryDarkPurple,
    secondaryMutedPurple,
    secondaryLightPurple,
  ];

  static const List<Color> darkGradient = [
    neutralDark,
    secondaryDarkPurple,
  ];
}
