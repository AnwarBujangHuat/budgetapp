import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/icons/custom_icon.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
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

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> pieChartDataList = [];
    return ref.watch(transactionViewmodelProvider).when(
      data: (data) {
        //Todo create a provider to handle all the colors
        List<TagModel> tagList = ref.watch(tagViewmodelProvider).asData!.value;
        for (int i = 0; i < data.length; i++) {
          pieChartDataList.add(pieChartData(
              value: double.parse(data[i].transactionAmount),
              tagId: data[i].tagId,
              color: getColorFromHex(tagList
                  .firstWhere((element) => element.tagId == data[i].tagId)
                  .color),
              isTouched: touchedIndex == i));
        }

        return AspectRatio(
          aspectRatio: 1.8,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2,
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
                      startDegreeOffset: 180,
                      sections: pieChartDataList,
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
                              data.elementAt(i).title,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IBIcon(tagId: data.elementAt(i).tagId)
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
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return Container();
      },
    );
  }
}

PieChartSectionData pieChartData(
    {required double value,
    required int tagId,
    required Color color,
    bool isTouched = false}) {
  final fontSize = isTouched ? 25.0 : 16.0;
  final radius = isTouched ? 60.0 : 50.0;
  return PieChartSectionData(
      radius: radius,
      value: value,
      color: color,
      titleStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize));
}
