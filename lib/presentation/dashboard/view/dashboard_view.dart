import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/button/transaction_type_button.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/domain/repository/tag/tag_repository.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:budgetapp/presentation/dashboard/widget/expanded_fab.dart';
import 'package:budgetapp/presentation/dashboard/widget/list_card_transaction.dart';
import 'package:budgetapp/presentation/dashboard/widget/list_goal_card.dart';
import 'package:budgetapp/presentation/dashboard/widget/pie_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/tab_duration.dart';
import 'package:budgetapp/presentation/dashboard/widget/total_text.dart';
import 'package:budgetapp/shared/dialog/ib_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(tagRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.dashboard),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.analytics_outlined,
              ),
              onPressed: () => {}),
        ],
      ),
      floatingActionButton: IBFlaotingFAB(
        distance: 60,
        children: [
          ActionButton(
            title: AppLocalizations.of(context)!.transaction,
            onPressed: () async =>
                {Navigator.pushNamed(context, RouteNames.transactionPage)},
            icon: const Icon(Icons.attach_money),
          ),
          ActionButton(
            title: AppLocalizations.of(context)!.importTransaction,
            onPressed: () => {},
            icon: const Icon(Icons.attachment_sharp),
          ),
        ],
      ),
      body: RefreshIndicator(
        //TODO handle refresh list here
        onRefresh: () async {
          final _ = await ref.refresh(transactionViewmodelProvider.future);
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          children: const [
            MyHeader(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IBTranscationListWidget(),
                IBGoalListWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyHeader extends ConsumerWidget {
  const MyHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final selectedPeriod = ref.watch(selectedPeriodProvider);
    return Card(
      color: AppColors.darkBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TimelineTab(
                selected: selectedPeriod,
                onTap: (selected) =>
                    ref.read(selectedPeriodProvider.notifier).state = selected,
              ),
            ),
            const IBSizedH20(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(transactionTypeNotifierProvider) !=
                                      TransactionType.income
                                  ? AppLocalizations.of(context)!.totalExpenses
                                  : AppLocalizations.of(context)!.totalIncome,
                              style: theme.textTheme.titleSmall!
                                  .copyWith(color: AppColors.white),
                            ),
                            const IBSizedH05(),
                            TotalTransactionValue(),
                          ],
                        ),
                      ),
                      IntrinsicWidth(
                        /// Ensures IBTransactionTypeWidget takes minimal width
                        child: IBTransactionTypeWidget(
                          transactionType:
                              ref.watch(transactionTypeNotifierProvider),
                          shadowColor: Colors.transparent,
                          onChange: (type) => ref
                              .read(transactionTypeNotifierProvider.notifier)
                              .changeType(type: type),
                        ),
                      ),
                    ],
                  ),
                  IBPieChartWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
