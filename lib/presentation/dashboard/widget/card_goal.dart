import 'package:budgetapp/common/utils/utils.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    required this.onPressed,
    required this.title,
    required this.description,
    required this.progress,
    required this.total,
    required this.startDate,
    required this.endDate,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final double total;
  final String description;
  final double progress;
  final DateTime startDate;
  final DateTime endDate;

  int calculateDaysLeft(
      {required DateTime startDate, required DateTime? endDate}) {
    if (endDate == null) {
      //Todo Unspecified Due Date
      return -1;
    }
    Duration difference = endDate.difference(startDate);

    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: currentTheme.textTheme.titleSmall),
                Text(description, style: currentTheme.textTheme.labelSmall),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Do handle for multiple currencies
                Text(
                    'RM ${progress.toStringAsFixed(2)} / RM ${total.toStringAsFixed(2)}',
                    style: currentTheme.textTheme.labelSmall),
                Text('${((progress / total) * 100).toInt()}%',
                    style: currentTheme.textTheme.labelSmall),
              ],
            ),
            _LinearProgressIndicator(
              value: progress,
              total: total,
            ),
            Text(
                '${calculateDaysLeft(startDate: startDate, endDate: endDate)} Days Left',
                style: currentTheme.textTheme.labelSmall),
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
  Widget build(BuildContext context) => LinearProgressIndicator(
      minHeight: 8,
      value: value / total,
      backgroundColor: Colors.grey.withOpacity(.5),
      color: calculateProgressColor(value: value, total: total),
      borderRadius: BorderRadius.circular(10));
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
                    color: calculateProgressColor(value: value, total: total),
                    value: value / total,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${(value / total * 100).toStringAsFixed(0)}%',
                  style: currentTheme.textTheme.titleLarge!.copyWith(
                      color:
                          calculateProgressColor(value: value, total: total)),
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
