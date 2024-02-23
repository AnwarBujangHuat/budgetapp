import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
    fontFamily: 'RobotoFlex',
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBlue,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(
            fontSize: AppFontSizes.title1,
            color: AppColors.white,
            fontWeight: FontWeight.bold)),
    cardColor: AppColors.white,
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
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: AppColors.offWhite),
    primaryColorLight: AppColors.darkBlue,
    primaryColor: AppColors.darkBlue);
ThemeData darkThemeData = ThemeData(
  fontFamily: 'RobotoFlex',
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
  static const Color primaryDarkBackground = Color.fromARGB(255, 19, 19, 20);
  static const Color secondaryDarkBackground = Color(0xFF1F212A);
  static const Color darkBlueVariant = Color(0xFF202531);
  static const Color lightGreen = Colors.green;
  static const Color lightGreenVariant = Colors.lightGreen;
  static const Color lightRed = Colors.red;
  static const Color lightRedVariant = Colors.redAccent;
  static const Color darkYellow = Color(0xFFFFD700);
  static const Color lightYellow = Color(0xFFFFFF00);
  static const Color lightYellowVariant = Color(0xFFFFFACD);
}

class AppFontSizes {
  static const double title4 = 34.0;

  static const double title1 = 28.0;

  static const double title2 = 22.0;

  static const double title3 = 20.0;

  static const double headline = 17.0;

  static const double subheadline = 15.0;

  static const double body = 16.0;

  static const double callout = 16.0;

  static const double footnote = 13.0;

  static const double caption1 = 12.0;

  static const double caption2 = 11.0;
}
