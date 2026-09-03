import 'package:flutter/material.dart';

/// Centralized brand colors and color tokens for JJ CRM application.
class AppColors {
  // Brand Base Colors
  static const Color limeGreen = Color(0xFF74C043);
  static const Color skyBlue = Color(0xFF009EE2);

  // Backgrounds & Surfaces
  static const Color appBackground = Color(0xFFF8FAFC); // Clean crisp off-white
  static const Color appBackgroundAlt = Color(0xFFF4F7FB);
  static const Color cardSurface = Color(0xFFFFFFFF); // Pure white
  static const Color cardBorder = Color(0xFFE2E8F0); // Subtle border
  static const Color divider = Color(0xFFF1F5F9);

  // Mesh Glow Accents (10% Opacity)
  static const Color meshGlowGreen = Color(0x1A74C043);
  static const Color meshGlowBlue = Color(0x1A009EE2);
  static const Color meshGlowCyan = Color(0x1A06B6D4);
  static const Color meshGlowViolet = Color(0x1A8B5CF6);

  // Vibrant Multi-Color Palette
  static const Color primaryBlue = Color(0xFF009EE2);
  static const Color secondaryGreen = Color(0xFF74C043);
  static const Color emeraldGreen = Color(0xFF10B981);
  static const Color cyanAccent = Color(0xFF06B6D4);
  static const Color mintAccent = Color(0xFF059669);
  static const Color violetAccent = Color(0xFF8B5CF6);
  static const Color purpleAccent = Color(0xFFA855F7);
  static const Color amberAccent = Color(0xFFF59E0B);
  static const Color orangeAccent = Color(0xFFF97316);
  static const Color roseAccent = Color(0xFFF43F5E);
  static const Color indigoAccent = Color(0xFF6366F1);

  // Typography & Contrast
  static const Color headingText = Color(0xFF0F172A); // Deep navy/slate
  static const Color bodyText = Color(0xFF475569);    // Charcoal slate
  static const Color mutedText = Color(0xFF94A3B8);   // Soft gray
  static const Color lightText = Color(0xFFCBD5E1);

  // Tinted Badge Backgrounds & Text
  static const Color badgeBlueBg = Color(0xFFE0F2FE);
  static const Color badgeBlueText = Color(0xFF0284C7);

  static const Color badgeGreenBg = Color(0xFFECFDF5);
  static const Color badgeGreenText = Color(0xFF059669);

  static const Color badgeCyanBg = Color(0xFFCFFAFE);
  static const Color badgeCyanText = Color(0xFF0891B2);

  static const Color badgeVioletBg = Color(0xFFF3E8FF);
  static const Color badgeVioletText = Color(0xFF7C3AED);

  static const Color badgeAmberBg = Color(0xFFFEF3C7);
  static const Color badgeAmberText = Color(0xFFD97706);

  static const Color badgeRoseBg = Color(0xFFFFE4E6);
  static const Color badgeRoseText = Color(0xFFE11D48);

  static const Color badgeIndigoBg = Color(0xFFE0E7FF);
  static const Color badgeIndigoText = Color(0xFF4F46E5);

  static const Color badgeOrangeBg = Color(0xFFFFEDD5);
  static const Color badgeOrangeText = Color(0xFFEA580C);

  // Modern Multi-Color Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [limeGreen, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF009EE2), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient roseGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFE11D48)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF0284C7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardAccentGradient = LinearGradient(
    colors: [limeGreen, skyBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient limeBlueGradient = LinearGradient(
    colors: [Color(0xFF74C043), Color(0xFF009EE2)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Tinted Shadows
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x14009EE2),
    blurRadius: 20,
    spreadRadius: 0,
    offset: Offset(0, 8),
  );

  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0F0F172A),
    blurRadius: 15,
    spreadRadius: 0,
    offset: Offset(0, 4),
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: Color(0x3D74C043),
    blurRadius: 12,
    spreadRadius: 0,
    offset: Offset(0, 4),
  );

  // Helper to generate a colorful avatar background based on text/name
  static Color getAvatarColor(String name) {
    if (name.isEmpty) return skyBlue;
    final int hash = name.codeUnits.fold(0, (prev, element) => prev + element);
    const colors = [
      Color(0xFF009EE2), // Sky Blue
      Color(0xFF10B981), // Emerald
      Color(0xFF8B5CF6), // Violet
      Color(0xFFF59E0B), // Amber
      Color(0xFFF43F5E), // Rose
      Color(0xFF06B6D4), // Cyan
      Color(0xFF6366F1), // Indigo
      Color(0xFF74C043), // Lime
      Color(0xFFF97316), // Orange
    ];
    return colors[hash.abs() % colors.length];
  }
}

