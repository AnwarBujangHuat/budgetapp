import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IBTransactionTypeWidget extends ConsumerWidget {
  const IBTransactionTypeWidget({
    required this.onChange,
    super.key,
    this.backgroundColor,
    this.transactionType = TransactionType.out,
    this.shadowColor,
  });
  final Color? backgroundColor;
  final Color? shadowColor;
  final TransactionType transactionType;
  final Function(TransactionType type) onChange;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IBOutlinedButton(
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      borderColors: transactionType != TransactionType.income
          ? AppColors.lightRed
          : AppColors.lightGreen,
      titleBuilder: Builder(
        builder: (context) => Text(
          transactionType == TransactionType.income
              ? AppLocalizations.of(context)!.income
              : AppLocalizations.of(context)!.expenses,
          style: TextStyle(
            color: transactionType != TransactionType.income
                ? AppColors.lightRed
                : AppColors.lightGreen,
          ),
        ),
      ),
      icon: Icon(
        Icons.compare_arrows,
        size: 24,
        color: transactionType != TransactionType.income
            ? AppColors.lightRed
            : AppColors.lightGreen,
      ),
      onTap: () => onChange(transactionType),
    );
  }
}
