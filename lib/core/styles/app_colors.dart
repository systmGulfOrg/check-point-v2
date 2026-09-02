import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color brandPrimary = Color(0xFFF57C00);
  static const Color brandPrimaryDark = Color(0xFFE36F00);
  static const Color brandSecondary = Color(0xFF4B5563);
  static const Color brandInk = Color(0xFF334155);
  static const Color brandGradientStart = Color(0xFFFFA726);
  static const Color brandGradientEnd = Color(0xFFE86F00);
  static const LinearGradient brandGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [brandGradientStart, brandGradientEnd],
  );

  static const Color pageBackground = Color(0xFFF7F2EB);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFFFFFFF);
  static const Color softBrandBackground = Color(0xFFFFF1E3);
  static const Color selectedBackground = Color(0xFFFFE8D1);
  static const Color shadow = Color(0x140F172A);
  static const Color infoBackground = Color(0xFFFFF6ED);
  static const Color iconTileBackground = Color(0xFFFFF3E6);

  static const Color textPrimary = Color(0xFF344054);
  static const Color textSecondary = Color(0xFF667085);
  static const Color placeholder = Color(0xFF98A2B3);

  static const Color border = Color(0xFFD6DDEA);
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color info = Color(0xFF2563EB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;

  // Admin dark theme & dashboard colors
  static const Color darkPageBackground = Color(0xFF090E1A);
  static const Color darkCardBackground = Color(0xFF101B35);
  static const Color darkCardBorder = Color(0xFF1E2D50);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);
  static const Color cyanAccent = Color(0xFF00B4D8);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color darkIconBoxBlue = Color(0xFF0D2847);
  static const Color darkIconBoxGreen = Color(0xFF0B2E25);
  static const Color darkIconBoxYellow = Color(0xFF332707);
  static const Color darkIconBoxCyan = Color(0xFF0E2338);
  static const Color darkBadgeBackground = Color(0xFF1E293B);

  // Soft light theme tile backgrounds
  static const Color softGreenBackground = Color(0xFFDCFCE7);
  static const Color softYellowBackground = Color(0xFFFEF3C7);
  static const Color softBlueBackground = Color(0xFFDBEAFE);
  static const Color softRedBackground = Color(0xFFFEE2E2);
  static const Color authShellGradientStart = Color(0xFFFFF7F0);

  // Employee dark theme badges & tiles
  static const Color darkStatusGreenBg = Color(0xFF0B2E25);
  static const Color darkStatusGreenText = Color(0xFF10B981);
  static const Color darkStatusRedBg = Color(0xFF3B1219);
  static const Color darkStatusRedText = Color(0xFFEF4444);
  static const Color darkStatusBlueBg = Color(0xFF0D2847);
  static const Color darkStatusBlueText = Color(0xFF3B82F6);
  static const Color darkIconBoxPink = Color(0xFF2A1526);
  static const Color darkIconBoxPinkText = Color(0xFFEC4899);
  static const Color darkIconBoxYellowText = Color(0xFFEAB308);
}
