import 'package:budgetapp/app/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimelineTab extends StatelessWidget {
  const TimelineTab({required this.onTap, required this.selected, super.key});
  final Function(String) onTap;
  final String selected;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<String> filterButton = <String>[
      AppLocalizations.of(context)!.daily,
      AppLocalizations.of(context)!.weekly,
      AppLocalizations.of(context)!.monthly,
      AppLocalizations.of(context)!.yearly,
    ];

    return SizedBox(
      height: 40,
      width: width * .9,
      child: Row(
        children: [
          for (int index = 0; index < filterButton.length; index++)
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(filterButton[index]),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white),
                      color: selected == filterButton[index]
                          ? AppColors.white
                          : AppColors.darkBlueLessOpacity,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(index == 0 ? 5 : 0),
                          topLeft: Radius.circular(index == 0 ? 5 : 0),
                          bottomRight: Radius.circular(
                              index + 1 == filterButton.length ? 5 : 0),
                          topRight: Radius.circular(
                              index + 1 == filterButton.length ? 5 : 0))),
                  child: Center(
                      child: Text(
                    filterButton[index],
                    style: TextStyle(
                        color: selected == filterButton[index]
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
