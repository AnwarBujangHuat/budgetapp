import 'package:budgetapp/src/presentation/common_widgets/header.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_font.dart';
import '../../common_widgets/globalStyle.dart';
import '../../settings/settings_view.dart';
import '../widget/expandedFab.dart';
import '../widget/line_chart.dart';

const List<String> filterButton = <String>[
  'Yearly',
  'Monthly',
  'Weekly',
  'Daily'
];
final selectedButtonProvider = StateProvider<String?>((_) => null);
final selectedPeriodProvider = StateProvider<String>((_) => filterButton[0]);

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    String selectedValue = ref.watch(selectedButtonProvider) ??
        AppLocalizations.of(context)!.expenses;

    final selectedPeriod = ref.watch(selectedPeriodProvider);
    return Scaffold(
      floatingActionButton: FlaotingFAB(
        distance: 60,
        children: [
          ActionButton(
            title: AppLocalizations.of(context)!.income,
            onPressed: () => print("object"),
            icon: const Icon(Icons.attach_money),
          ),
          ActionButton(
            title: AppLocalizations.of(context)!.expenses,
            onPressed: () => print("object"),
            icon: const Icon(Icons.payment),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("Refresh");
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          shrinkWrap: true,
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(color: AppColors.darkBlue),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(AppLocalizations.of(context)!.dashboard,
                        style: const TextStyle(
                            fontSize: AppFontSizes.title1,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold)),
                    leading: GestureDetector(
                      onTap: () => Navigator.restorablePushNamed(
                          context, SettingsView.routeName),
                      child: const Icon(
                        Icons.menu,
                        color: AppColors.white,
                      ),
                    ),
                  ),
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
                              width: width * .92,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: filterButton.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(
                                                selectedPeriodProvider.notifier)
                                            .state = filterButton[index];
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color: selectedPeriod != filterButton[index]
                                                ? Colors.transparent
                                                : AppColors.offWhite,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    index == 0 ? 5 : 0),
                                                topLeft: Radius.circular(
                                                    index == 0 ? 5 : 0),
                                                bottomRight: Radius.circular(
                                                    index + 1 == filterButton.length
                                                        ? 5
                                                        : 0),
                                                topRight: Radius.circular(
                                                    index + 1 == filterButton.length
                                                        ? 5
                                                        : 0))),
                                        width: width * .23,
                                        child: Center(
                                            child: Text(
                                          filterButton[index],
                                          style: TextStyle(
                                              color: selectedPeriod !=
                                                      filterButton[index]
                                                  ? AppColors.white
                                                  : AppColors.darkBlueVariant),
                                        )),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                    const SizedBox(
                                      height: 5,
                                    ),
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
                  const Header(title: "Goals"),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(5),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        width: 250,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            boxShadow: [GlobalStyle.boxShadow],
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(0))),
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container()),
                      ),
                      itemCount: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Header(title: "Transaction"),
                  SizedBox(
                    height: 310,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 2),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          boxShadow: [GlobalStyle.boxShadow],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container()),
                      ),
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
