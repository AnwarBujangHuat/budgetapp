import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
    fontFamily: 'RobotoFlex',
    scaffoldBackgroundColor: AppColors.offWhite,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBlue,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: FontSize.mediumTitle)),
    cardColor: AppColors.white,
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        letterSpacing: 0,
        fontSize: FontSize.smallTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      titleMedium: TextStyle(
        letterSpacing: 0,
        fontSize: FontSize.mediumTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      titleLarge: TextStyle(
        letterSpacing: 0,
        fontSize: FontSize.largeTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      displaySmall: TextStyle(
        letterSpacing: 0,
        fontSize: FontSize.smallDisplay,
        color: AppColors.darkBlue,
      ),
      displayMedium: TextStyle(
        fontSize: FontSize.mediumDisplay,
        fontWeight: FontWeight.w900,
        color: AppColors.darkBlue,
      ),
      displayLarge: TextStyle(
        fontSize: FontSize.largeDisplay,
        color: AppColors.darkBlue,
      ),
      bodySmall: TextStyle(
        fontSize: FontSize.subtitle,
        color: AppColors.darkBlue,
      ),
      bodyMedium: TextStyle(
        fontSize: FontSize.body,
        color: AppColors.darkBlue,
      ),
      bodyLarge: TextStyle(
        fontSize: FontSize.smallTitle,
        color: AppColors.darkBlue,
      ),
      labelMedium: TextStyle(
        letterSpacing: 0,
        fontSize: FontSize.body,
        color: AppColors.darkBlue,
      ),
      labelSmall: TextStyle(
        letterSpacing: 0,
        fontSize: FontSize.subtitle,
        color: AppColors.darkBlueLessOpacity,
      ),
    ),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.darkBlue,
        onPrimary: AppColors.darkBlue,
        secondary: AppColors.darkBlueVariant,
        onSecondary: AppColors.white,
        error: AppColors.lightRed,
        onError: AppColors.lightRedVariant,
        background: AppColors.offWhite,
        onBackground: AppColors.offWhite,
        surface: Colors.white,
        onSurface: AppColors.black),
    cardTheme: const CardTheme(
      surfaceTintColor: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: AppColors.offWhite),
    primaryColorLight: AppColors.darkBlue,
    primaryColor: AppColors.darkBlue);
ThemeData darkThemeData = ThemeData(
  cardColor: AppColors.cardBackgroundColor,
  scaffoldBackgroundColor: AppColors.primaryDarkBackground,
  primaryColorLight: AppColors.whiteVariant,
);

class AppColors {
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color offWhiteVariant = Colors.white70;
  static const Color white = Colors.white;
  static const Color whiteVariant = Color(0xFFF8F8F8);
  static const Color black = Colors.black;
  static const Color cardBackgroundColor = Color.fromARGB(255, 28, 28, 28);
  static const Color blackVariant = Color(0xFF333333);
  static const Color darkBlue = Color(0xFF282D49);
  static const Color darkBlueLessOpacity = Color(0xB3282D49);
  static const Color primaryDarkBackground = Color.fromARGB(255, 19, 19, 20);
  static const Color secondaryDarkBackground = Color(0xFF1F212A);
  static const Color darkBlueVariant = Color(0xFF202531);
  static const Color lightGreen = Color(0xCC4F9360);
  static const Color lightRed = Colors.red;
  static const Color lightRedVariant = Colors.redAccent;
  static const Color darkYellow = Color(0xFFFFD700);
  static const Color lightYellow = Color(0xFFFFFF00);
  static const Color lightYellowVariant = Color(0xFFFFFACD);
}

class FontSize {
  static const double largeDisplay = 96;
  static const double mediumDisplay = 48;
  static const double smallDisplay = 32;
  static const double largeTitle = 24;
  static const double mediumTitle = 20;
  static const double smallTitle = 16;
  static const double body = 14;
  static const double subtitle = 12;
}
