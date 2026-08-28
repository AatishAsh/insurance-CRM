import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: AppColors.skyBlue,
      onPrimary: Colors.white,
      primaryContainer: AppColors.badgeBlueBg,
      onPrimaryContainer: AppColors.badgeBlueText,
      secondary: AppColors.limeGreen,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.badgeGreenBg,
      onSecondaryContainer: AppColors.badgeGreenText,
      tertiary: AppColors.cyanAccent,
      onTertiary: Colors.white,
      surface: AppColors.cardSurface,
      onSurface: AppColors.headingText,
      surfaceContainerHighest: AppColors.appBackgroundAlt,
      onSurfaceVariant: AppColors.bodyText,
      outline: AppColors.cardBorder,
      outlineVariant: AppColors.divider,
      error: AppColors.roseAccent,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.appBackground,

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.bold, fontSize: 32),
        displayMedium: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.bold, fontSize: 28),
        displaySmall: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.bold, fontSize: 24),
        headlineMedium: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.bold, fontSize: 20),
        headlineSmall: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.w700, fontSize: 18),
        titleLarge: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.w700, fontSize: 16),
        titleMedium: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.w600, fontSize: 14),
        titleSmall: TextStyle(color: AppColors.bodyText, fontWeight: FontWeight.w600, fontSize: 13),
        bodyLarge: TextStyle(color: AppColors.bodyText, fontSize: 15, height: 1.4),
        bodyMedium: TextStyle(color: AppColors.bodyText, fontSize: 14, height: 1.4),
        bodySmall: TextStyle(color: AppColors.mutedText, fontSize: 12, height: 1.3),
        labelLarge: TextStyle(color: AppColors.headingText, fontWeight: FontWeight.w600, fontSize: 14),
        labelMedium: TextStyle(color: AppColors.mutedText, fontWeight: FontWeight.w500, fontSize: 12),
        labelSmall: TextStyle(color: AppColors.mutedText, fontWeight: FontWeight.w500, fontSize: 11),
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        backgroundColor: AppColors.cardSurface,
        foregroundColor: AppColors.headingText,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.headingText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
        iconTheme: IconThemeData(color: AppColors.headingText),
        actionsIconTheme: IconThemeData(color: AppColors.skyBlue),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 0,
        shadowColor: AppColors.meshGlowBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),

      // Navigation Bar (Bottom Nav)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.cardSurface,
        elevation: 6,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.badgeBlueBg,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.skyBlue, size: 24);
          }
          return const IconThemeData(color: AppColors.mutedText, size: 22);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.skyBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: AppColors.mutedText,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          );
        }),
      ),

      // Navigation Rail (Desktop Nav)
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.cardSurface,
        elevation: 2,
        indicatorColor: AppColors.badgeBlueBg,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        selectedIconTheme: const IconThemeData(color: AppColors.skyBlue, size: 24),
        unselectedIconTheme: const IconThemeData(color: AppColors.mutedText, size: 22),
        selectedLabelTextStyle: const TextStyle(
          color: AppColors.skyBlue,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: const TextStyle(
          color: AppColors.mutedText,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.skyBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.skyBlue,
          side: const BorderSide(color: AppColors.skyBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.skyBlue,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.skyBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Input Decoration (TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cardBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.skyBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.roseAccent, width: 1),
        ),
        hintStyle: const TextStyle(color: AppColors.mutedText, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.bodyText, fontSize: 14),
        prefixIconColor: AppColors.mutedText,
        suffixIconColor: AppColors.mutedText,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.badgeBlueBg,
        deleteIconColor: AppColors.badgeBlueText,
        disabledColor: AppColors.divider,
        selectedColor: AppColors.skyBlue,
        secondarySelectedColor: AppColors.limeGreen,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        labelStyle: const TextStyle(color: AppColors.badgeBlueText, fontWeight: FontWeight.w600, fontSize: 12),
        secondaryLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.cardSurface,
        elevation: 10,
        shadowColor: AppColors.meshGlowBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.cardBorder),
        ),
        titleTextStyle: const TextStyle(
          color: AppColors.headingText,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(
          color: AppColors.bodyText,
          fontSize: 14,
        ),
      ),

      // TabBar Theme
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.skyBlue,
        unselectedLabelColor: AppColors.mutedText,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(color: AppColors.skyBlue, width: 3),
          borderRadius: BorderRadius.circular(3),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
