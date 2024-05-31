import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/icons/custom_icon.dart';
import 'package:budgetapp/common/widgets/text/header.dart';
import 'package:budgetapp/shared/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IBTranscationListWidget extends ConsumerWidget {
  const IBTranscationListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int maxDisplayTrascation = 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IBTextHeader(
                title: AppLocalizations.of(context)!.recentTransaction),
            IBTextButton(
              title: 'View More',
              onTap: () {},
            ),
          ],
        ),
        //Todo make locale for this
        Card(
          child: ref.watch(transactionViewmodelProvider).when(
                data: (transactionList) {
                  return transactionList.isEmpty
                      ? IBCard(
                          title: 'Add New Transaction',
                          icon: IconWidget(
                            iconData: Icons.add,
                            backgroundColor: AppColors.slateBlue,
                          ),
                          description: 'No Transaction Record Found')
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => IBTransactionCard(
                            //Todo open page for transaction details, like a reciept page
                            onPressed: () {},
                            title: transactionList[index].title,
                            date: transactionList[index].dateTime,
                            tagId: transactionList[index].tagId,
                            type: transactionList[index].type,
                            expenses: double.parse(
                                transactionList[index].transactionAmount),
                          ),
                          itemCount:
                              transactionList.length > maxDisplayTrascation
                                  ? maxDisplayTrascation
                                  : transactionList.length,
                        );
                },
                error: (error, stackTrace) => Container(
                  height: 100,
                  child: Text(error.toString()),
                ),
                loading: () => Container(),
              ),
        )
      ],
    );
  }
}

class IBTransactionCard extends ConsumerWidget {
  const IBTransactionCard({
    required this.onPressed,
    required this.title,
    required this.date,
    required this.expenses,
    super.key,
    this.type = TransactionType.income,
    this.tagId = 0,
  });
  final VoidCallback onPressed;
  final String title;
  final DateTime date;
  final double expenses;
  final int tagId;
  final TransactionType type;

  @override
  Widget build(BuildContext context, ref) {
    ThemeData currentTheme = Theme.of(context);
    return ListTile(
      minVerticalPadding: 0,
      dense: true,
      leading: IBIcon(tagId: tagId),
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
