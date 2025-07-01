import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFBBDEFB);

  // Accent Colors
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentRed = Color(0xFFF44336);
  static const Color accentPurple = Color(0xFF9C27B0);
  static const Color accentTeal = Color(0xFF009688);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Tag Colors
  static const List<Color> tagColors = [
    Color(0xFFE3F2FD), // Light Blue
    Color(0xFFE8F5E8), // Light Green
    Color(0xFFFFF3E0), // Light Orange
    Color(0xFFF3E5F5), // Light Purple
    Color(0xFFE0F2F1), // Light Teal
    Color(0xFFFCE4EC), // Light Pink
    Color(0xFFF1F8E9), // Light Lime
    Color(0xFFFFF8E1), // Light Amber
  ];

  // Priority Colors
  static const Color priorityHigh = accentRed;
  static const Color priorityMedium = accentOrange;
  static const Color priorityLow = accentGreen;

  // Status Colors
  static const Color success = accentGreen;
  static const Color warning = accentOrange;
  static const Color error = accentRed;
  static const Color info = primaryBlue;

  // Background Colors
  static const Color backgroundLight = white;
  static const Color backgroundDark = grey900;
  static const Color surfaceLight = grey100;
  static const Color surfaceDark = grey800;

  // Text Colors
  static const Color textPrimary = grey900;
  static const Color textSecondary = grey600;
  static const Color textDisabled = grey400;
  static const Color textOnPrimary = white;

  // Border Colors
  static const Color borderLight = grey300;
  static const Color borderDark = grey600;
}
