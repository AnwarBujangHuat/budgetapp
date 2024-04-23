import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/widgets/button/transaction_type_button.dart';
import 'package:budgetapp/domain/repository/tag/tag_repository.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:budgetapp/presentation/dashboard/widget/expanded_fab.dart';
import 'package:budgetapp/presentation/dashboard/widget/line_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/list_card_transaction.dart';
import 'package:budgetapp/presentation/dashboard/widget/list_goal_card.dart';
import 'package:budgetapp/presentation/dashboard/widget/pie_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/sized_boxes.dart';
import 'package:budgetapp/presentation/dashboard/widget/tab_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    print('COME HERE Init');

    ref.read(tagRepositoryProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
            ),
            onPressed: null,
          ),
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
            title: 'Import Transaction',
            onPressed: () => {},
            icon: const Icon(Icons.attachment_sharp),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          shrinkWrap: true,
          children: const [
            MyHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IBTranscationListWidget(),
                  IBGoalListWidget(),
                ],
              ),
            )
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

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(color: AppColors.darkBlue),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: screenWidth,
                  child: TimelineTab(
                    selected: selectedPeriod,
                    onTap: (selected) => ref
                        .read(selectedPeriodProvider.notifier)
                        .state = selected,
                  ),
                ),
                const IBSizedH20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ref.watch(selectedButtonProvider) !=
                                  TransactionType.income
                              ? AppLocalizations.of(context)!.totalExpenses
                              : AppLocalizations.of(context)!.totalIncome,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: AppColors.offWhiteVariant),
                        ),
                        const IBSizedH05(),
                        Text(
                          'RM 9700',
                          style: theme.textTheme.displaySmall!
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    IBTransactionTypeWidget()
                  ],
                ),
                IBPieChartWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyLineChartWidget extends ConsumerWidget {
  const MyLineChartWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    TransactionType selectedValue = ref.watch(selectedButtonProvider);

    return SizedBox(
      height: 200,
      child:
          LineChartWidget(isExpenses: selectedValue == TransactionType.income),
    );
  }
}
