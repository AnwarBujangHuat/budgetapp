import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/transaction/viewmodel/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/header.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:budgetapp/presentation/dashboard/widget/card_goal.dart';
import 'package:budgetapp/presentation/dashboard/widget/card_transaction.dart';
import 'package:budgetapp/presentation/dashboard/widget/expanded_fab.dart';
import 'package:budgetapp/presentation/dashboard/widget/line_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/sized_boxes.dart';
import 'package:budgetapp/presentation/dashboard/widget/tab_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dashboard),
        leading: GestureDetector(
          child: const Icon(Icons.menu),
        ),
      ),
      floatingActionButton: FlaotingFAB(
        distance: 60,
        children: [
          ActionButton(
            title: AppLocalizations.of(context)!.income,
            onPressed: () => {
              ref.read(transactionViewmodelProvider.notifier).insertNewdata()
            },
            icon: const Icon(Icons.attach_money),
          ),
          ActionButton(
            title: AppLocalizations.of(context)!.expenses,
            onPressed: () => {},
            icon: const Icon(Icons.payment),
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
                children: [
                  MyGoals(),
                  MyTransactions(),
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

    String selectedValue = ref.watch(selectedButtonProvider) ??
        AppLocalizations.of(context)!.expenses;

    final selectedPeriod = ref.watch(selectedPeriodProvider);

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(color: AppColors.darkBlue),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: screenWidth * .92,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: filterButton.length,
                    itemBuilder: (context, index) => TimelineTab(
                      selected: selectedPeriod,
                      onTap: () => ref
                          .read(selectedPeriodProvider.notifier)
                          .state = filterButton[index],
                    ),
                  ),
                ),
                const SizedH20(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalNetWorth,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: AppColors.offWhiteVariant),
                        ),
                        const SizedH05(),
                        Text(
                          "RM 9700",
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
                                : AppColors.lightGreen,
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
                                      : AppColors.lightGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
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
  const MyGoals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AHeader(title: "Goals"),
        ref.watch(transactionViewmodelProvider).when(
          loading: () {
            return const Text('Loading');
          },
          data: (dataList) {
            return SizedBox(
              height: 160,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedW10(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GoalCard(
                  onPressed: () {},
                  title: "Savings For Da Future",
                  description: 'Description',
                  total: 120,
                  progress: 80,
                  startDate: DateTime.now(),
                  endDate: DateTime.now().copyWith(day: DateTime.now().day + 5),
                ),
                itemCount: 3,
              ),
            );
          },
          error: (error, stack) {
            return Container();
          },
        ),
        const SizedH10(),
      ],
    );
  }
}

class MyTransactions extends StatelessWidget {
  const MyTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AHeader(title: "Transactions"),
        ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => TransactionCard(
            onPressed: () {},
            title: 'title',
            description: 'description',
          ),
          itemCount: 10,
        ),
      ],
    );
  }
}
