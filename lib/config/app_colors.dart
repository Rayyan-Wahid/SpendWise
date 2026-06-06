import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Main blue used in hero header background
  static const Color primary = Color(0xFF1679D4);

  /// Accent blue — FAB, active nav, focused borders, buttons
  static const Color accent = Color(0xFF3B82F6);

  /// Darker accent — selected pill text
  static const Color accentDark = Color(0xFF1D4ED8);

  /// Light accent fill — selected pill background, edit button bg
  static const Color accentLight = Color(0xFFEFF6FF);

  // ── Backgrounds ────────────────────────────────────────────────────
  /// Page / scaffold background
  static const Color background = Color(0xFFF1F5F9);

  /// Card / surface background
  static const Color surface = Color(0xFFFFFFFF);

  /// Input field fill
  static const Color inputFill = Color(0xFFF8FAFC);

  // ── Text ───────────────────────────────────────────────────────────
  /// Primary text — titles, amounts, labels
  static const Color textPrimary = Color(0xFF1E293B);

  /// Muted text — dates, subtitles, hints
  static const Color textMuted = Color(0xFF94A3B8);

  /// Light muted — empty state icons, dividers
  static const Color textLight = Color(0xFFCBD5E1);

  /// White text — used on blue hero header
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Semi-transparent white — hero subtitles
  static const Color textOnPrimaryMuted = Color(0xB3FFFFFF);

  /// Default card border
  static const Color border = Color(0x0F000000);

  /// Input field border
  static const Color inputBorder = Color(0xFFE2E8F0);

  /// Drag handle / dividers
  static const Color divider = Color(0xFFE2E8F0);

  // ── Semantic ───────────────────────────────────────────────────────
  /// Delete / danger — trash icon, delete text
  static const Color danger = Color(0xFFEF4444);

  static const Color dangerLight = Color(0xFFFEF2F2);

  // ── Category colors ────────────────────────────────────────────────
  static const Color categoryFood = Color(0xFF059669);
  static const Color categoryFoodBg = Color(0xFFECFDF5);

  static const Color categoryTransport = Color(0xFF3B82F6);
  static const Color categoryTransportBg = Color(0xFFEFF6FF);

  static const Color categoryUtilities = Color(0xFFD97706);
  static const Color categoryUtilitiesBg = Color(0xFFFFFBEB);

  static const Color categoryShopping = Color(0xFFEC4899);
  static const Color categoryShoppingBg = Color(0xFFFDF2F8);

  static const Color categoryHealth = Color(0xFFEF4444);
  static const Color categoryHealthBg = Color(0xFFFFF1F2);

  static const Color categoryOther = Color(0xFF6B7280);
  static const Color categoryOtherBg = Color(0xFFF3F4F6);

  /// Returns the color for a category name.
  static Color forCategory(String category) {
    switch (category) {
      case 'Food':
        return categoryFood;
      case 'Transport':
        return categoryTransport;
      case 'Utilities':
        return categoryUtilities;
      case 'Shopping':
        return categoryShopping;
      case 'Health':
        return categoryHealth;
      default:
        return categoryOther;
    }
  }

  /// Returns the background/fill color for a category name.
  static Color bgForCategory(String category) {
    switch (category) {
      case 'Food':
        return categoryFoodBg;
      case 'Transport':
        return categoryTransportBg;
      case 'Utilities':
        return categoryUtilitiesBg;
      case 'Shopping':
        return categoryShoppingBg;
      case 'Health':
        return categoryHealthBg;
      default:
        return categoryOtherBg;
    }
  }
}
