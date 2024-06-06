import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IBTransactionTypeWidget extends ConsumerWidget {
  const IBTransactionTypeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButton = ref.watch(selectedTransactionTypeProvider);

    return GestureDetector(
      onTap: () {
        ref.read(selectedTransactionTypeProvider.notifier).state =
            selectedButton == TransactionType.income
                ? TransactionType.out
                : TransactionType.income;
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedButton != TransactionType.income
                ? AppColors.lightRed
                : AppColors.green,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                selectedButton == TransactionType.income
                    ? AppLocalizations.of(context)!.income
                    : AppLocalizations.of(context)!.expenses,
                style: TextStyle(
                  color: selectedButton != TransactionType.income
                      ? AppColors.lightRed
                      : AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const IBSizedW05(),
              Icon(
                Icons.compare_arrows,
                size: 16,
                color: selectedButton != TransactionType.income
                    ? AppColors.lightRed
                    : AppColors.lightGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
