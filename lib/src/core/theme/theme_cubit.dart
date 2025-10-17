import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDarkMode: false));

  static const String _themeKey = 'isDarkMode';

  /// Initialize theme from shared preferences
  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeKey) ?? false;
    emit(ThemeState(isDarkMode: isDarkMode));
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newThemeMode = !state.isDarkMode;
    
    await prefs.setBool(_themeKey, newThemeMode);
    emit(ThemeState(isDarkMode: newThemeMode));
  }

  /// Get the current theme data
  ThemeData get themeData => state.isDarkMode ? ThemeCubit.darkTheme : ThemeCubit.lightTheme;

  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryPurple,
      brightness: Brightness.light,
      primary: AppColors.primaryPurple,
      secondary: AppColors.primaryBlueViolet,
      surface: AppColors.lightSurface,
      onPrimary: AppColors.lightOnPrimary,
      onSecondary: AppColors.lightOnPrimary,
      onSurface: AppColors.lightOnSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightOnSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: AppColors.lightOnPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'InterTight',
      ),
      displayMedium: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFamily: 'InterTight',
      ),
      displaySmall: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      headlineLarge: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      headlineMedium: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      headlineSmall: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      titleLarge: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      titleMedium: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      titleSmall: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      bodyLarge: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: 'InterTight',
      ),
      bodyMedium: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: 'InterTight',
      ),
      bodySmall: TextStyle(
        color: AppColors.lightOnSurface,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        fontFamily: 'InterTight',
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightOnSurface,
      thickness: 0.5,
    ),
  );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryPurple,
      brightness: Brightness.dark,
      primary: AppColors.primaryPurple,
      secondary: AppColors.primaryBlueViolet,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.darkOnPrimary,
      onSecondary: AppColors.darkOnPrimary,
      onSurface: AppColors.darkOnSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: AppColors.darkOnPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'InterTight',
      ),
      displayMedium: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFamily: 'InterTight',
      ),
      displaySmall: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      headlineLarge: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      headlineMedium: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      headlineSmall: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      titleLarge: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      titleMedium: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      titleSmall: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'InterTight',
      ),
      bodyLarge: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: 'InterTight',
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: 'InterTight',
      ),
      bodySmall: TextStyle(
        color: AppColors.darkOnSurface,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        fontFamily: 'InterTight',
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkOnSurface,
      thickness: 0.5,
    ),
  );
}
