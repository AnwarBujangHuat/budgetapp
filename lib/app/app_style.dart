import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
    fontFamily: 'RobotoFlex',
    scaffoldBackgroundColor: AppColors.rarifiedAir,
    buttonTheme: ButtonThemeData(height: AppSize.appSizeS50),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.darkBlue),
        titleTextStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: FontSize.largeTitle)),
    cardColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        constraints: BoxConstraints(minHeight: AppSize.appSizeS60),
        filled: true,
        iconColor: AppColors.black,
        contentPadding: EdgeInsets.all(8),
        labelStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          letterSpacing: AppSize.appSizeS0,
          fontSize: FontSize.body,
          color: AppColors.darkBlue,
        ),
        hintStyle: TextStyle(
          letterSpacing: AppSize.appSizeS0,
          fontSize: FontSize.body,
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey),
            borderRadius: BorderRadius.circular(10))),
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.smallTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      titleMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.mediumTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      titleLarge: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.largeTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBlue,
      ),
      displaySmall: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.smallDisplay,
        color: AppColors.darkBlue,
      ),
      displayMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: FontSize.mediumDisplay,
        fontWeight: FontWeight.w900,
        color: AppColors.darkBlue,
      ),
      displayLarge: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: FontSize.largeDisplay,
        color: AppColors.darkBlue,
      ),
      bodySmall: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: FontSize.subtitle,
        color: AppColors.darkBlue,
      ),
      bodyMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: FontSize.body,
        color: AppColors.darkBlue,
      ),
      bodyLarge: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: FontSize.smallTitle,
        color: AppColors.darkBlue,
      ),
      labelMedium: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.body,
        color: AppColors.darkBlueLessOpacity,
      ),
      labelSmall: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.subtitle,
        color: AppColors.darkBlueLessOpacity,
      ),
      labelLarge: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.smallTitle,
        color: AppColors.darkBlueLessOpacity,
      ),
    ),
    iconTheme: IconThemeData(size: 24),
    datePickerTheme: DatePickerThemeData(
        dayStyle: TextStyle(color: Colors.white),
        // dayOverlayColor: WidgetStatePropertyAll(AppColors.white),
        surfaceTintColor: Colors.white),
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.darkBlue,
        onPrimary: AppColors.white,
        secondary: AppColors.darkBlueVariant,
        onSecondary: AppColors.white,
        error: AppColors.lightRed,
        onError: AppColors.white,
        surface: Colors.white,
        onSurface: AppColors.darkBlueLessOpacity),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.rarifiedAir),
            minimumSize: WidgetStatePropertyAll(
                Size(AppSize.appSizeS0, AppSize.appSizeS48)),
            textStyle: WidgetStatePropertyAll(
              TextStyle(overflow: TextOverflow.ellipsis),
            ),
            shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.appSizeS10),
              ),
            ))),
    cardTheme: const CardTheme(
      surfaceTintColor: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.appSizeS16)),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: AppColors.rarifiedAir),
    primaryColorLight: AppColors.darkBlue,
    primaryColor: AppColors.darkBlue);
ThemeData darkThemeData = ThemeData(
  dialogBackgroundColor: AppColors.coarseWool,
  iconTheme: IconThemeData(color: AppColors.white),
  scaffoldBackgroundColor: AppColors.darkBlueBlack,
  shadowColor: AppColors.white,
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBlueBlack,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.largeTitle)),
  cardColor: AppColors.coarseWool,
  inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkBlueBlack,
      filled: true,
      iconColor: AppColors.white,
      suffixIconColor: AppColors.white,
      contentPadding: EdgeInsets.all(AppSize.paddingMedium),
      labelStyle: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.body,
        color: AppColors.white,
      ),
      hintStyle: TextStyle(
        letterSpacing: AppSize.appSizeS0,
        fontSize: FontSize.body,
        color: AppColors.grey,
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(10))),
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.smallTitle,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.mediumTitle,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    titleLarge: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.largeTitle,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    displaySmall: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.smallDisplay,
      color: AppColors.white,
    ),
    displayMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: FontSize.mediumDisplay,
      fontWeight: FontWeight.w900,
      color: AppColors.white,
    ),
    displayLarge: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: FontSize.largeDisplay,
      color: AppColors.white,
    ),
    bodySmall: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: FontSize.subtitle,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: FontSize.body,
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: FontSize.smallTitle,
      color: AppColors.white,
    ),
    labelMedium: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.body,
      color: AppColors.whiteVariant,
    ),
    labelSmall: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.subtitle,
      color: AppColors.whiteVariant,
    ),
    labelLarge: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: AppSize.appSizeS0,
      fontSize: FontSize.smallTitle,
      color: AppColors.whiteVariant,
    ),
  ),
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.white,
      onPrimary: AppColors.rarifiedAir,
      secondary: AppColors.white,
      onSecondary: AppColors.white,
      error: AppColors.lightRed,
      onError: AppColors.lightRed,
      surface: AppColors.secondaryDarkBackground,
      onSurface: AppColors.secondaryDarkBackground),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.darkBlueBlack),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ))),
  cardTheme: const CardTheme(
    surfaceTintColor: AppColors.secondaryDarkBackground,
    elevation: 1,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(circularTrackColor: AppColors.white),
  primaryColorLight: AppColors.white,
  primaryColor: AppColors.white,
);

class AppColors {
  static const Color rarifiedAir = Color(0xFFF2F3F8);
  static const Color white = Colors.white;
  static const Color whiteVariant = Color(0xFFF8F8F8);
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color cardBackgroundColor = Color.fromARGB(255, 28, 28, 28);
  static const Color blackVariant = Color(0xFF333333);
  static const Color darkBlue = Color(0xFF282D49);
  static const Color darkBlueLessOpacity = Color(0xB3282D49);
  static const Color primaryDarkBackground = Color(0xFF252627);
  static const Color secondaryDarkBackground = Color(0xFF303030);
  static const Color darkBlueVariant = Color(0xFF202531);
  static const Color lightGreen = Color.fromARGB(204, 128, 223, 135);
  static const Color lighterGreen = Color(0xCC8EFFA8);
  static const Color lightRed = Colors.red;
  static const Color lightRedVariant = Colors.redAccent;
  static const Color darkYellow = Color(0xFFFFD700);
  static const Color lightYellow = Color(0xFFFFFF00);
  static const Color lightYellowVariant = Color(0xFFFFFACD);
  static const Color purple = Color(0xFF7E59B3);
  static const Color orange = Color(0xFFFA7F72);
  static const Color green = Color(0xFF62BC76);
  static const Color yellow = Color(0xFFFFD166);
  static const Color lightPurple = Color(0xFFA79DF3);
  static const Color pink = Color(0xFFFA7F72);
  static const Color teal = Color(0xFF64C4D6);
  static const Color slateBlue = Color(0xFF62758D);
  static const Color pantoneBlue = Color(0xFF0a192f);
  static const Color pantoneCoated = Color(0xFF172a46);
  static const Color darkBlueBlack = Color(0xFF0c0e19);
  static const Color coarseWool = Color(0xFF171d24);
  static const Color dodgerBlue = Color(0xFF5787e9);
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

class AppSize {
  static const double appSizeS96 = 96.0;
  static const double appSizeS60 = 60.0;
  static const double appSizeS50 = 50.0;
  static const double appSizeS48 = 48.0;
  static const double appSizeS32 = 32.0;
  static const double appSizeS24 = 24.0;
  static const double appSizeS20 = 20.0;
  static const double appSizeS16 = 16.0;
  static const double appSizeS14 = 14.0;
  static const double appSizeS12 = 12.0;
  static const double appSizeS0 = 0.0;

  // Add more common sizes
  static const double appSizeS8 = 8.0;
  static const double appSizeS10 = 10.0;
  static const double appSizeS4 = 4.0;
  static const double appSizeS2 = 2.0;

  static const double appSizeS1 = 1.0; // For very thin borders or separators

  // Common icon sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;

  // Common padding and margin sizes
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Common border radius sizes
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusExtraLarge = 16.0;

  // Common elevation sizes for shadows
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
}
