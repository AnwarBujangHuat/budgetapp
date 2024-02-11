import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:budgetapp/presentation/dashboard/widget/card_goal.dart';
import 'package:budgetapp/presentation/dashboard/widget/expanded_fab.dart';
import 'package:budgetapp/presentation/dashboard/widget/line_chart.dart';
import 'package:budgetapp/presentation/dashboard/widget/sized_boxes.dart';
import 'package:budgetapp/presentation/settings/settings_view.dart';
import 'package:budgetapp/shared/appbar.dart';
import 'package:budgetapp/shared/header.dart';
import 'package:budgetapp/presentation/dashboard/widget/card_transaction.dart';
import 'package:budgetapp/presentation/dashboard/widget/tab_duration.dart';
import 'package:budgetapp/presentation/transaction/transaction_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
          padding: const EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          children: const [
            MyHeader(),
            MyLineChartWidget(),
            SizedBox(height: 10),
            MyGoals(),
            SizedBox(height: 10),
            MyTransactions(),
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
    String selectedValue = ref.watch(selectedButtonProvider) ??
        AppLocalizations.of(context)!.expenses;

    final selectedPeriod = ref.watch(selectedPeriodProvider);

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(color: AppColors.darkBlue),
      child: Column(
        children: [
          MTAppBar(
              title: AppLocalizations.of(context)!.dashboard,
              onPressedBack: () => Navigator.restorablePushNamed(
                  context, SettingsView.routeName)),
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
                          style: const TextStyle(
                            fontSize: AppFontSizes.subheadline,
                            color: AppColors.offWhiteVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedH05(),
                        const Text(
                          "RM 9700",
                          style: TextStyle(
                            fontSize: AppFontSizes.title4,
                            color: AppColors.offWhite,
                            fontWeight: FontWeight.bold,
                          ),
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
                                : AppColors.lightGreenVariant,
                          ),
                          color: Colors.transparent,
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
                                  fontSize: AppFontSizes.subheadline,
                                  color: selectedValue !=
                                          AppLocalizations.of(context)!.income
                                      ? AppColors.lightRed
                                      : AppColors.lightGreenVariant,
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
                                    : AppColors.lightGreenVariant,
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

    return Container(
      decoration: const BoxDecoration(color: AppColors.darkBlue),
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
        const SizedH10(),
        const AHeader(title: "Goals"),
        ref.watch(transactionViewmodelProvider).when(
          loading: () {
            return const Text('Loading');
          },
          loaded: (dataList) {
            return SizedBox(
              height: 170,
              child: ListView.separated(
                padding: const EdgeInsets.all(5),
                separatorBuilder: (context, index) => const SizedW10(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GoalCard(
                  onPressed: () {},
                  title: index.toString(),
                  description: '',
                  total: 100,
                  progress: 80,
                ),
                itemCount: 1,
              ),
            );
          },
          error: (appException) {
            return SizedBox(
              height: 150,
              child: ListView.separated(
                padding: const EdgeInsets.all(5),
                separatorBuilder: (context, index) => const SizedW10(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const SizedBox(
                  width: 250,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("j"),
                    ),
                  ),
                ),
                itemCount: 2,
              ),
            );
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => TransactionCard(
              onPressed: () {},
              title: 'title',
              description: 'description',
            ),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
