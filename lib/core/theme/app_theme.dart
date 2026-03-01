import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      useMaterial3: true,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        surface: AppColors.surface,
        background: AppColors.background,
        secondary: AppColors.accent,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        titleLarge: AppTextStyles.heading,
        titleMedium: AppTextStyles.subtitle,
        bodyMedium: AppTextStyles.body,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
