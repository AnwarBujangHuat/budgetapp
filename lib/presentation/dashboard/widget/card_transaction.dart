import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.onPressed,
    required this.title,
    required this.date,
    required this.expenses,
    super.key,
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
    return ListTile(
      minVerticalPadding: 0,
      dense: true,
      leading: getCategoryIcon(category: category),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(title, style: currentTheme.textTheme.titleSmall),
      subtitle: Text(formatDate(dateTime: date),
          style: currentTheme.textTheme.labelSmall),
      trailing: Text('RM ${expenses.toStringAsFixed(2)}',
          style: currentTheme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: type == TransactionType.out
                  ? AppColors.lightRed
                  : AppColors.lightGreen)),
    );
  }
}
