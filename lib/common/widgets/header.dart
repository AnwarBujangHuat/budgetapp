import 'package:flutter/material.dart';

class AHeader extends StatelessWidget {
  const AHeader({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(title, style: theme.textTheme.titleMedium),
    );
  }
}
