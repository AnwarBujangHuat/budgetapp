import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IBPieChartWidget extends ConsumerStatefulWidget {
  const IBPieChartWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IBPieChartWidgetState();
}

class _IBPieChartWidgetState extends ConsumerState<IBPieChartWidget> {
  int touchedIndex = -1;
  Set<TransactionCategory> temp = {
    TransactionCategory.clothing,
    TransactionCategory.dining,
    TransactionCategory.education,
    TransactionCategory.entertainment,
    TransactionCategory.grocery,
    TransactionCategory.utilities,
    TransactionCategory.travel,
    TransactionCategory.rent,
  };

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    for (int i = 0; i < temp.length; i++)
                      pieChartData(
                          value: 20,
                          category: temp.elementAt(i),
                          isTouched: touchedIndex == i),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (int i = 0; i <= 4; i++)
                if (i < 4)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          temp.elementAt(i).name,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        getCategoryIcon(category: temp.elementAt(i)),
                      ],
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '...Others',
                  style: TextStyle(color: AppColors.offWhiteVariant),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

PieChartSectionData pieChartData(
    {required double value,
    required TransactionCategory category,
    bool isTouched = false}) {
  final fontSize = isTouched ? 25.0 : 16.0;
  final radius = isTouched ? 60.0 : 50.0;
  return PieChartSectionData(
      radius: radius,
      value: 30,
      color: getCategoryColor(category: category),
      titleStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize));
}
