import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/presentation/dashboard/widget/sized_boxes.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.onPressed,
    required this.title,
    required this.date,
    required this.expenses,
    this.type = TransactionType.income,
    this.category = TransactionCategory.other,
  });
  final VoidCallback onPressed;
  final String title;
  final DateTime date;
  final double expenses;
  final TransactionCategory category;
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            getCategoryIcon(category: category),
            const SizedW10(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: currentTheme.textTheme.titleSmall),
                  Text(formatDate(dateTime: date),
                      style: currentTheme.textTheme.labelSmall),
                ],
              ),
            ),
            Text('RM $expenses',
                style: currentTheme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: type == TransactionType.out
                        ? AppColors.lightRed
                        : AppColors.lightGreen)),
          ],
        ),
      ),
    );
  }
}
