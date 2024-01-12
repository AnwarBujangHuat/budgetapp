import 'package:budgetapp/src/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimelineTab extends StatelessWidget {
  const TimelineTab({super.key, required this.onTap, required this.selected});
  final Function() onTap;
  final String selected;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<String> filterButton = <String>[
      AppLocalizations.of(context)!.yearly,
      AppLocalizations.of(context)!.monthly,
      AppLocalizations.of(context)!.weekly,
      AppLocalizations.of(context)!.daily,
    ];

    return SizedBox(
      height: 40,
      width: width * .92,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: filterButton.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: selected != filterButton[index]
                        ? Colors.transparent
                        : AppColors.offWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(index == 0 ? 5 : 0),
                        topLeft: Radius.circular(index == 0 ? 5 : 0),
                        bottomRight: Radius.circular(
                            index + 1 == filterButton.length ? 5 : 0),
                        topRight: Radius.circular(
                            index + 1 == filterButton.length ? 5 : 0))),
                width: width * .23,
                child: Center(
                    child: Text(
                  filterButton[index],
                  style: TextStyle(
                      color: selected != filterButton[index]
                          ? AppColors.white
                          : AppColors.darkBlueVariant),
                )),
              ),
            );
          }),
    );
  }
}
