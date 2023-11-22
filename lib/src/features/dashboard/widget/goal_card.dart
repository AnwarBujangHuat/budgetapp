import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.description,
      required this.progress});
  final VoidCallback onPressed;
  final String title;
  final String description;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return Card(
      color: currentTheme.dialogBackgroundColor,
      elevation: 5, // Add shadow to the card
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(width: 250, child: Text(title)),
    );
  }
}
