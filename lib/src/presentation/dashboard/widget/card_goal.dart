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
    return Card(
      child: SizedBox(width: 250, child: Text(title)),
    );
  }
}
