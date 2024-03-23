import 'package:budgetapp/app/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../presentation/dashboard/view/dashboard_view.dart';
import '../presentation/settings/settings_controller.dart';
import '../presentation/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    required this.settingsController,
    super.key,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) => MaterialApp(
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
            Locale('en'),
            Locale('ms'),
            Locale('zh'),
          ],
          locale: const Locale('en', ''),
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) =>
              MaterialPageRoute<void>(
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
          ),
        ),
      );
}
