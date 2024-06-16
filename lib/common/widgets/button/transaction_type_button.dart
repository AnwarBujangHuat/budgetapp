import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IBTransactionTypeWidget extends ConsumerWidget {
  const IBTransactionTypeWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButton = ref.watch(selectedTransactionTypeProvider);

    return IBOutlinedButton(
      borderColors: selectedButton != TransactionType.income
          ? AppColors.lightRed
          : AppColors.lightGreen,
      titleBuilder: Builder(
        builder: (context) => Text(
          selectedButton == TransactionType.income
              ? AppLocalizations.of(context)!.income
              : AppLocalizations.of(context)!.expenses,
          style: TextStyle(
            color: selectedButton != TransactionType.income
                ? AppColors.lightRed
                : AppColors.lightGreen,
          ),
        ),
      ),
      icon: Icon(
        Icons.compare_arrows,
        size: 24,
        color: selectedButton != TransactionType.income
            ? AppColors.lightRed
            : AppColors.lightGreen,
      ),
      onTap: () {
        ref.read(selectedTransactionTypeProvider.notifier).state =
            selectedButton == TransactionType.income
                ? TransactionType.out
                : TransactionType.income;
      },
    );
  }
}
