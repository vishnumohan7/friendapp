import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const primaryColor = Color(0xFF7F5AFF);
  static const secondaryColor = Color(0xFF5A8CFF);
  
  // Background Colors
  static const backgroundColor = Colors.white;
  static const scaffoldBackground = Color(0xFFF8F9FF);
  
  // Text Colors
  static const textColor = Color(0xFF2D2D2D);
  static const lightTextColor = Color(0xFF7B7B7B);
  static const whiteTextColor = Colors.white;
  
  // Status Colors
  static const errorColor = Color(0xFFFF4B4B);
  static const successColor = Color(0xFF4CAF50);
  static const warningColor = Color(0xFFFFA000);
  
  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryColor, secondaryColor],
  );
  
  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textColor,
    height: 1.3,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: lightTextColor,
    height: 1.5,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  // Theme Data
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: Colors.white,
      background: scaffoldBackground,
    ),
    scaffoldBackgroundColor: scaffoldBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
      labelStyle: const TextStyle(
        color: lightTextColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        textStyle: buttonText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: buttonText.copyWith(color: Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: buttonText.copyWith(
          color: primaryColor,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: heading1,
      displayMedium: heading2,
      bodyLarge: bodyText,
      bodyMedium: bodyText,
      labelLarge: buttonText,
    ),
  );
}
