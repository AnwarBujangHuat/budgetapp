import 'package:budgetapp/src/config/app_colors.dart';
import 'package:budgetapp/src/features/dashboard/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/sample_item_details_view.dart';
import 'features/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
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
              scaffoldBackgroundColor: AppColors.offWhite,
              cardColor: AppColors.white,
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
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case DashboardView.routeName:
                    return const DashboardView();
                  case SampleItemListView.routeName:
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
