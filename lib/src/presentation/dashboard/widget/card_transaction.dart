import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.onPressed,
    required this.title,
    required this.description,
  });
  final VoidCallback onPressed;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(height: 60, child: Text(title)),
    );
  }
}
