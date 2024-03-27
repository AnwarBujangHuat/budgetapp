import 'package:flutter/material.dart';

class IBCard extends StatelessWidget {
  const IBCard(
      {required this.title,
      required this.icon,
      required this.description,
      super.key});
  final String title;
  final Widget icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        title: Text(
          title,
          style: theme.textTheme.titleSmall,
        ),
        subtitle: Text(
          description,
          style: theme.textTheme.labelSmall,
        ),
        leading: icon,
      ),
    );
  }
}
