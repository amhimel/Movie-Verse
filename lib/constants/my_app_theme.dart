import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';

class MyAppTheme {

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: MyAppColors.lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyAppColors.lightPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(secondary: MyAppColors.lightSecondaryColor),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyAppColors.darkElevatedButtonColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: MyAppColors.darkPrimaryColor,
    scaffoldBackgroundColor: MyAppColors.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyAppColors.darkBackgroundColor,
      foregroundColor: Colors.white,
      elevation: 1,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.dark(
      primary: MyAppColors.darkPrimaryColor,
      secondary: MyAppColors.darkSecondaryColor,
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[900],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyAppColors.darkElevatedButtonColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: MyAppColors.progressIndicatorColor,
      )

  );
}
