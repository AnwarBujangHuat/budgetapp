import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/app.dart';
import 'presentation/settings/settings_controller.dart';
import 'presentation/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(
    ProviderScope(child: MyApp(settingsController: settingsController)),
  );
}
