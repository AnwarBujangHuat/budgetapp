import 'package:flutter/material.dart';

class AHeader extends StatelessWidget {
  const AHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Text(title, style: theme.textTheme.titleLarge),
    );
  }
}
