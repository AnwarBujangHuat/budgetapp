import 'package:budgetapp/src/app/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
    fontFamily: 'RobotoFlex',
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.offWhite),
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
