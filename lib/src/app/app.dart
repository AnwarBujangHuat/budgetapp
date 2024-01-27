import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../presentation/dashboard/view/dashboard_view.dart';
import '../presentation/settings/settings_controller.dart';
import '../presentation/settings/settings_view.dart';
import 'app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // showPerformanceOverlay: true,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', null),
            Locale('ms', null),
            Locale('zh', null),
          ],
          locale: const Locale('en', ''),
          theme: ThemeData(
              fontFamily: 'RobotoFlex',
              appBarTheme:
                  const AppBarTheme(backgroundColor: AppColors.offWhite),
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
              primaryColor: AppColors.darkBlue),
          darkTheme: ThemeData.dark().copyWith(
            cardColor: AppColors.cardBackgroundColor,
            scaffoldBackgroundColor: AppColors.primaryDarkBackground,
            primaryColorLight: AppColors.whiteVariant,

            // Add more customizations as needed
          ),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);

                  case DashboardView.routeName:
                    return const DashboardView();

                  default:
                    return const DashboardView();
                }
              },
            );
          },
        );
      },
    );
  }
}
