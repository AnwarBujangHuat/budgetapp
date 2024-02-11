import 'package:budgetapp/app/app_style.dart';
import 'package:flutter/material.dart';

class AHeader extends StatelessWidget {
  const AHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title,
          style: TextStyle(
              fontSize: AppFontSizes.title2,
              color: theme.primaryColorLight,
              fontWeight: FontWeight.bold)),
    );
  }
}
