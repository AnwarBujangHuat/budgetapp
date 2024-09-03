import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimelineTab extends StatelessWidget {
  const TimelineTab({required this.onTap, required this.selected, super.key});
  final Function(TransactionDuration) onTap;
  final TransactionDuration selected;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Map<TransactionDuration, String> filterButton = {
      TransactionDuration.daily: AppLocalizations.of(context)!.daily,
      TransactionDuration.weekly: AppLocalizations.of(context)!.weekly,
      TransactionDuration.monthly: AppLocalizations.of(context)!.monthly,
      TransactionDuration.yearly: AppLocalizations.of(context)!.yearly,
    };

    return SizedBox(
      height: AppSize.appSizeS48,
      width: width * .9,
      child: Row(
        children: [
          for (int index = 0; index < filterButton.length; index++)
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(filterButton.keys.elementAt(index)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white),
                      color: selected == filterButton.keys.elementAt(index)
                          ? AppColors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(index == 0 ? 5 : 0),
                          topLeft: Radius.circular(index == 0 ? 5 : 0),
                          bottomRight: Radius.circular(
                              index + 1 == filterButton.length ? 5 : 0),
                          topRight: Radius.circular(
                              index + 1 == filterButton.length ? 5 : 0))),
                  child: Center(
                      child: Text(
                    filterButton.values.elementAt(index),
                    style: TextStyle(
                        color: selected == filterButton.keys.elementAt(index)
                            ? AppColors.darkBlue
                            : AppColors.white),
                  )),
                ),
              ),
            )
        ],
      ),
    );
  }
}
