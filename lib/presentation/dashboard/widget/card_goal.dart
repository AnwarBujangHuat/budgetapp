import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TITLE', style: TextStyle(fontWeight: FontWeight.bold)),
            _LinearProgressIndicator(
              value: progress,
              total: total,
            ),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  const _LinearProgressIndicator({required this.value, required this.total});
  final double value;
  final double total;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
        minHeight: 8,
        value: value / total,
        backgroundColor: Colors.amber,
        color: calculateProgressColor(value, total),
        borderRadius: BorderRadius.circular(10));
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
                    color: calculateProgressColor(value, total),
                    strokeWidth: 4,
                    value: value / total,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${(value / total * 100).toStringAsFixed(0)}%',
                  style: currentTheme.textTheme.titleLarge!
                      .copyWith(color: calculateProgressColor(value, total)),
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
