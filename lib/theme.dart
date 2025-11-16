import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFF25C54);
const Color secondaryColor = Color(0xFFF2B90C);
const Color tertiaryColor = Color(0xFF4C5958);

// Using default TextTheme to avoid network requests for fonts
final TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
  bodyMedium: TextStyle(fontSize: 14),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
  ),
  textTheme: appTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
  ),
  textTheme: appTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
);
