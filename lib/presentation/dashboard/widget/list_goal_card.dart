import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/goals/goals_viewmodel.dart';
import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/icons/custom_icon.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/common/widgets/text/header.dart';
import 'package:budgetapp/shared/card/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IBGoalListWidget extends ConsumerWidget {
  const IBGoalListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(goalsViewmodelProvider).when(
          loading: () => const Text('Loading'),
          data: (goalList) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IBTextHeader(title: AppLocalizations.of(context)!.goals),
                  IBTextButton(
                    title: AppLocalizations.of(context)!.viewMore,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                  height: 130,
                  child: goalList.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) =>
                              const IBSizedW10(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => IBGoalCard(
                            onPressed: () {},
                            title: goalList[index].title,
                            description: goalList[index].description,
                            total: goalList[index].total.toDouble(),
                            progress: goalList[index].progress.toDouble(),
                            startDate: goalList[index].startDate,
                            endDate: goalList[index].endDate,
                          ),
                          itemCount: goalList.length,
                        )
                      : IBCard(
                          title: AppLocalizations.of(context)!.setupGoals,
                          icon: IconWidget(
                            iconData: Icons.add,
                            backgroundColor: AppColors.slateBlue,
                          ),
                          description: AppLocalizations.of(context)!.noGoals)),
              const IBSizedH10(),
            ],
          ),
          error: (error, stack) => Container(
            height: 100,
            child: Text(error.toString()),
          ),
        );
  }
}

class IBGoalCard extends StatelessWidget {
  const IBGoalCard({
    required this.onPressed,
    required this.title,
    required this.description,
    required this.progress,
    required this.total,
    required this.startDate,
    required this.endDate,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final double total;
  final String description;
  final double progress;
  final DateTime startDate;
  final DateTime endDate;

  int calculateDaysLeft(
      {required DateTime startDate, required DateTime? endDate}) {
    if (endDate == null) {
      //Todo Unspecified Due Date
      return -1;
    }
    Duration difference = endDate.difference(startDate);

    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: currentTheme.textTheme.titleSmall),
                Text(description, style: currentTheme.textTheme.labelSmall),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Do handle for multiple currencies
                Text(
                    'RM ${progress.toStringAsFixed(2)} / RM ${total.toStringAsFixed(2)}',
                    style: currentTheme.textTheme.labelSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text('${((progress / total) * 100).toInt()}%',
                    style: currentTheme.textTheme.labelSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            _LinearProgressIndicator(
              value: progress,
              total: total,
            ),
            Text(
                '${calculateDaysLeft(startDate: startDate, endDate: endDate)} ${AppLocalizations.of(context)!.daysLeft}',
                style: currentTheme.textTheme.labelSmall!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  const _LinearProgressIndicator({required this.value, required this.total});
  final double value;
  final double total;

  @override
  Widget build(BuildContext context) => LinearProgressIndicator(
      minHeight: 8,
      value: value / total,
      backgroundColor: Colors.grey.withOpacity(.5),
      color: calculateProgressColor(value: value, total: total),
      borderRadius: BorderRadius.circular(10));
}

// ignore: unused_element
class _CircularProgressIndicator extends StatelessWidget {
  const _CircularProgressIndicator({required this.value, required this.total});
  final double value;
  final double total;

  @override
  Widget build(BuildContext context) {
    double boxHeight = 115;
    ThemeData currentTheme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: boxHeight,
          width: boxHeight,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: boxHeight,
                  width: boxHeight,
                  child: CircularProgressIndicator(
                    color: calculateProgressColor(value: value, total: total),
                    value: value / total,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${(value / total * 100).toStringAsFixed(0)}%',
                  style: currentTheme.textTheme.titleLarge!.copyWith(
                      color:
                          calculateProgressColor(value: value, total: total)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '${AppLocalizations.of(context)!.total}: RM${total.toStringAsFixed(2)}',
              style: currentTheme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
