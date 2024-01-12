import 'package:budgetapp/src/presentation/shared/appbar.dart';
import 'package:budgetapp/src/presentation/shared/header.dart';
import 'package:budgetapp/src/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:budgetapp/src/presentation/dashboard/widget/card_transaction.dart';
import 'package:budgetapp/src/presentation/dashboard/widget/tab_duration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/app_colors.dart';
import '../../../app/app_font.dart';
import '../../settings/settings_view.dart';
import '../widget/expanded_fab.dart';
import '../widget/line_chart.dart';
import '../widget/sized_boxes.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String selectedValue = ref.watch(selectedButtonProvider) ??
        AppLocalizations.of(context)!.expenses;

    final selectedPeriod = ref.watch(selectedPeriodProvider);
    return Scaffold(
      floatingActionButton: FlaotingFAB(
        distance: 60,
        children: [
          ActionButton(
            title: AppLocalizations.of(context)!.income,
            onPressed: () => {},
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
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(color: AppColors.darkBlue),
              child: Column(
                children: [
                  MTAppBar(
                      title: AppLocalizations.of(context)!.dashboard,
                      onPressedBack: () => Navigator.restorablePushNamed(
                          context, SettingsView.routeName)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            .read(
                                                selectedPeriodProvider.notifier)
                                            .state = filterButton[index],
                                      )),
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
                                        AppLocalizations.of(context)!
                                            .totalNetWorth,
                                        style: const TextStyle(
                                            fontSize: AppFontSizes.subheadline,
                                            color: AppColors.offWhiteVariant,
                                            fontWeight: FontWeight.bold)),
                                    const SizedH05(),
                                    const Text("RM 9700",
                                        style: TextStyle(
                                            fontSize: AppFontSizes.title4,
                                            color: AppColors.offWhite,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(selectedButtonProvider.notifier)
                                        .state = selectedValue ==
                                            AppLocalizations.of(context)!.income
                                        ? AppLocalizations.of(context)!.expenses
                                        : AppLocalizations.of(context)!.income;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: selectedValue !=
                                                    AppLocalizations.of(
                                                            context)!
                                                        .income
                                                ? AppColors.lightRed
                                                : AppColors.lightGreenVariant),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(selectedValue,
                                              style: TextStyle(
                                                  fontSize:
                                                      AppFontSizes.subheadline,
                                                  color: selectedValue !=
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .income
                                                      ? AppColors.lightRed
                                                      : AppColors
                                                          .lightGreenVariant,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.compare_arrows,
                                            size: 16,
                                            color: selectedValue !=
                                                    AppLocalizations.of(
                                                            context)!
                                                        .income
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: LineChartWidget(
                      isExpenses:
                          selectedValue == AppLocalizations.of(context)!.income,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedH10(),
                  const AHeader(title: "Goals"),
                  SizedBox(
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
                                child: Text("j"))),
                      ),
                      itemCount: 2,
                    ),
                  ),
                  const SizedH10(),
                  const AHeader(title: "Transactions"),
                  SizedBox(
                    height: screenHeight * .3,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 2),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => TransactionCard(
                          onPressed: () {},
                          title: 'title',
                          description: 'description'),
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
