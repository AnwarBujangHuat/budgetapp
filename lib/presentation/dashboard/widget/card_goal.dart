import 'package:budgetapp/app/app_colors.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.progress,
    required this.total,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final double total;
  final String description;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.6,
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
        child: Row(
          children: [
            _CircularProgressIndicator(
              value: progress,
              total: total,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color _calculateProgressColor(double value, double total) {
  double progress = value / total;
  if (progress == 0) return AppColors.black;

  if (progress < 0.4) {
    return AppColors.lightRed;
  } else if (progress < 0.6) {
    return AppColors.lightYellow;
  } else {
    return AppColors.lightGreen;
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  const _CircularProgressIndicator({required this.value, required this.total});
  final double value;
  final double total;

  @override
  Widget build(BuildContext context) {
    double boxHeight = 115;
    ThemeData currentTheme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: boxHeight,
          width: boxHeight,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: boxHeight,
                  width: boxHeight,
                  child: CircularProgressIndicator(
                    color: _calculateProgressColor(value, total),
                    strokeWidth: 4,
                    value: value / total,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${(value / total * 100).toStringAsFixed(0)}%',
                  style: currentTheme.textTheme.titleLarge!
                      .copyWith(color: _calculateProgressColor(value, total)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Total: RM${total.toStringAsFixed(2)}',
              style: currentTheme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
