import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/transaction/viewmodel/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/header.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:budgetapp/presentation/dashboard/widget/card_goal.dart';
import 'package:budgetapp/presentation/dashboard/widget/card_transaction.dart';
import 'package:budgetapp/presentation/dashboard/widget/expanded_fab.dart';
import 'package:budgetapp/presentation/dashboard/widget/line_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/pie_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/sized_boxes.dart';
import 'package:budgetapp/presentation/dashboard/widget/tab_duration.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
        floatingActionButton: FlaotingFAB(
          distance: 60,
          children: [
            ActionButton(
              title: AppLocalizations.of(context)!.transaction,
              onPressed: () async => {
                ref.read(transactionViewmodelProvider.notifier).insertNewdata()
              },
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
                    MyTransactions(),
                    MyGoals(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

class MyHeader extends ConsumerWidget {
  const MyHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    String selectedValue = ref.watch(selectedButtonProvider) ??
        AppLocalizations.of(context)!.expenses;

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
                const SizedH20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ref.watch(selectedButtonProvider) !=
                                  AppLocalizations.of(context)!.income
                              ? AppLocalizations.of(context)!.totalExpenses
                              : AppLocalizations.of(context)!.totalIncome,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: AppColors.offWhiteVariant),
                        ),
                        const SizedH05(),
                        Text(
                          'RM 9700',
                          style: theme.textTheme.displaySmall!
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        final selectedButton = ref.read(selectedButtonProvider);
                        ref.read(selectedButtonProvider.notifier).state =
                            selectedButton ==
                                    AppLocalizations.of(context)!.income
                                ? AppLocalizations.of(context)!.expenses
                                : AppLocalizations.of(context)!.income;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedValue !=
                                    AppLocalizations.of(context)!.income
                                ? AppColors.lightRed
                                : AppColors.lighterGreen,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                selectedValue,
                                style: TextStyle(
                                  color: selectedValue !=
                                          AppLocalizations.of(context)!.income
                                      ? AppColors.lightRed
                                      : AppColors.lighterGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedW05(),
                              Icon(
                                Icons.compare_arrows,
                                size: 16,
                                color: selectedValue !=
                                        AppLocalizations.of(context)!.income
                                    ? AppColors.lightRed
                                    : AppColors.lightGreen,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
    String selectedValue = ref.watch(selectedButtonProvider) ??
        AppLocalizations.of(context)!.expenses;

    return SizedBox(
      height: 200,
      child: LineChartWidget(
        isExpenses: selectedValue == AppLocalizations.of(context)!.income,
      ),
    );
  }
}

class MyGoals extends ConsumerWidget {
  const MyGoals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(transactionViewmodelProvider).when(
            loading: () => const Text('Loading'),
            data: (dataList) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AHeader(title: AppLocalizations.of(context)!.goals),
                    Icon(Icons.add)
                  ],
                ),
                SizedBox(
                    height: dataList.isNotEmpty ? 160 : 0,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => const SizedW10(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GoalCard(
                        onPressed: () {},
                        title: 'Savings For Da Future',
                        description: 'Description',
                        total: 120,
                        progress: 80,
                        startDate: DateTime.now(),
                        endDate: DateTime.now()
                            .copyWith(day: DateTime.now().day + 5),
                      ),
                      itemCount: dataList.length,
                    )),
                const SizedH10(),
              ],
            ),
            error: (error, stack) => Container(),
          );
}

class MyTransactions extends StatelessWidget {
  const MyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    int maxDisplayTrascation = 8;

    List<String> meow = ['Meow', '2', '3', '2', '3', '2', '3'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AHeader(title: AppLocalizations.of(context)!.recentTransaction),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => TransactionCard(
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
