import 'package:flutter/material.dart';

/// Class that defines the application theme
class AppTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  
  // Text colors
  static const Color textPrimaryLightColor = Color(0xFF121212);
  static const Color textSecondaryLightColor = Color(0xFF555555);
  static const Color textPrimaryDarkColor = Color(0xFFF5F5F5);
  static const Color textSecondaryDarkColor = Color(0xFFB0B0B0);
  
  // Background colors
  static const Color backgroundLightColor = Color(0xFFFFFFFF);
  static const Color backgroundDarkColor = Color(0xFF121212);
  
  // Accent colors for special elements
  static const Color accentColor = Color(0xFFFF5722);
  static const Color errorColor = Color(0xFFB00020);

  // Elevated button style
  static final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  );

  // Text button style
  static final TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  // Input decoration theme
  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      onPrimary: Colors.white,
      // ignore: deprecated_member_use
      background: backgroundLightColor,
    ),
    scaffoldBackgroundColor: backgroundLightColor,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      displayLarge: TextStyle(color: textPrimaryLightColor, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textPrimaryLightColor, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: textPrimaryLightColor, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: textPrimaryLightColor, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: textPrimaryLightColor, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: textPrimaryLightColor, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: textPrimaryLightColor),
      bodyMedium: TextStyle(color: textSecondaryLightColor),
    ),
    elevatedButtonTheme: elevatedButtonTheme,
    textButtonTheme: textButtonTheme,
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: Colors.grey[100],
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundLightColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textPrimaryLightColor),
      titleTextStyle: TextStyle(
        color: textPrimaryLightColor, 
        fontSize: 20, 
        fontWeight: FontWeight.bold
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey[600],
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      onPrimary: Colors.white,
      // ignore: deprecated_member_use
      background: backgroundDarkColor,
      surface: Color(0xFF1E1E1E),
    ),
    scaffoldBackgroundColor: backgroundDarkColor,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      displayLarge: TextStyle(color: textPrimaryDarkColor, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textPrimaryDarkColor, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: textPrimaryDarkColor, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: textPrimaryDarkColor, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: textPrimaryDarkColor, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: textPrimaryDarkColor, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: textPrimaryDarkColor),
      bodyMedium: TextStyle(color: textSecondaryDarkColor),
    ),
    elevatedButtonTheme: elevatedButtonTheme,
    textButtonTheme: textButtonTheme,
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: Color(0xFF2C2C2C),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDarkColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textPrimaryDarkColor),
      titleTextStyle: TextStyle(
        color: textPrimaryDarkColor, 
        fontSize: 20, 
        fontWeight: FontWeight.bold
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: secondaryColor,
      unselectedItemColor: Colors.grey[500],
    ),
  );
}