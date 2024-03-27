import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/widgets/custom_icon.dart';
import 'package:budgetapp/common/widgets/text/header.dart';
import 'package:budgetapp/shared/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IBTranscationListWidget extends StatelessWidget {
  const IBTranscationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int maxDisplayTrascation = 8;
    final theme = Theme.of(context);

    List<String> meow = ['Meow', '2', '3', '2', '3', '2', '3'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IBTextHeader(
                title: AppLocalizations.of(context)!.recentTransaction),
            Text('View More', style: theme.textTheme.labelMedium),
          ],
        ),
        //Todo make locale for this
        meow.isEmpty
            ? IBCard(
                title: 'Add New Transaction',
                icon: IBIcon(
                  iconData: Icons.add,
                  backgroundColor: AppColors.slateBlue,
                ),
                description: 'No Transaction Record Found')
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => IBTransactionCard(
                  onPressed: () {},
                  title: 'Groceries Shopping',
                  date: DateTime.now(),
                  category: TransactionCategory.grocery,
                  type: TransactionType.out,
                  expenses: 300,
                ),
                itemCount: meow.length > maxDisplayTrascation
                    ? maxDisplayTrascation
                    : meow.length,
              ),
      ],
    );
  }
}

class IBTransactionCard extends StatelessWidget {
  const IBTransactionCard({
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
