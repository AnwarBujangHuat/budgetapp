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
    int maxDisplayTrascation = 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IBTextHeader(
                  title: AppLocalizations.of(context)!.recentTransaction),
              IBTextButton(
                title: AppLocalizations.of(context)!.viewMore,
                onTap: () {},
              ),
            ],
          ),
        ),
        Container(
          child: ref.watch(transactionViewmodelProvider).when(
                data: (transactionList) {
                  return transactionList.isEmpty
                      ? IBCard(
                          title:
                              AppLocalizations.of(context)!.addNewTransaction,
                          icon: IconWidget(
                            iconData: Icons.add,
                            backgroundColor: AppColors.slateBlue,
                          ),
                          description:
                              AppLocalizations.of(context)!.noTransaction)
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => IBTransactionCard(
                            // Todo open page for transaction details, like a reciept page
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
                // Todo create a error handling page for retrieving transaction data from remote database
                error: (error, stackTrace) => Container(
                  height: 100,
                  child: Text(error.toString()),
                ),
                // Todo create a loading widget for the loading animation
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
      dense: true,
      leading: IBIcon(tagId: tagId),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(title, style: currentTheme.textTheme.titleSmall),
      subtitle: Text(formatDate(dateTime: date),
          style: currentTheme.textTheme.labelSmall),
      trailing: Text('RM ${expenses.toStringAsFixed(2)}',
          style: currentTheme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: type == TransactionType.out
                  ? AppColors.lightRed
                  : AppColors.lightGreen)),
    );
  }
}
