import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app/app.dart';
import 'src/presentation/settings/settings_controller.dart';
import 'src/presentation/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(
    ProviderScope(child: MyApp(settingsController: settingsController)),
  );
}
