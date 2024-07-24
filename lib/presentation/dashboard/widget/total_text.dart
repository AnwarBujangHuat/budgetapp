import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/presentation/dashboard/utils/dashboard_utils.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TotalTransactionValue extends ConsumerWidget {
  const TotalTransactionValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final transactionType = ref.watch(transactionTypeNotifierProvider);

    return ref.watch(transactionViewmodelProvider).when(
          //TODO do multi currency

          data: (transactionList) => Text(
              'RM ${getTotalTransaction(transactionList: transactionList, transactionType: transactionType).toStringAsFixed(2)}',
              style: theme.textTheme.displaySmall!
                  .copyWith(color: AppColors.white)),
          //TODO handle proper error

          error: (error, stackTrace) => Text(error.toString()),
          //TODO handle proper loading
          loading: () => Text('Loading'),
        );
  }
}
