import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0EA5A4);
  static const Color primaryContainer = Color(0xFF052F2F);
  static const Color background = Color(0xFF0B0F12);
  static const Color surface = Color(0xFF0F1620);
  static const Color card = Color(0xFF111827);
  static const Color accent = Color(0xFF7C3AED);
  static const Color glass = Color(0x14FFFFFF);
  static const Color textPrimary = Color(0xFFE6EEF3);
  static const Color textSecondary = Color(0xFF9AA6B2);
  static const Color success = Color(0xFF10B981);
  static const Color danger = Color(0xFFEF4444);
  // Legacy / extended colors used across older widgets
  static const Color primaryDark = Color(0xFF0B7280);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color backgroundSecondary = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFF233554);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  static const Color bmiCard = Color(0xFF3B82F6);
  static const Color currencyCard = Color(0xFF8B5CF6);
  static const Color metalCard = Color(0xFFFCD34D);
  static const Color historyCard = Color(0xFF06B6D4);

  static const Color shimmer = Color(0xFF475569);

  static List<Color> get gradientPrimary => [
        const Color(0xFF667EEA),
        const Color(0xFF764BA2),
      ];

  static List<Color> get gradientAccent => [
        const Color(0xFF06B6D4),
        const Color(0xFF3B82F6),
      ];
}

