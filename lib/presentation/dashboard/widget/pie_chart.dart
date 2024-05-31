import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/icons/custom_icon.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//TODO seperate the code to ensure theres no uncessary rerendring
class IBPieChartWidget extends ConsumerStatefulWidget {
  const IBPieChartWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IBPieChartWidgetState();
}

class _IBPieChartWidgetState extends ConsumerState<IBPieChartWidget> {
  int touchedKey = -1;

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> pieChartDataList = [];
    Color textColor = Colors.white;
    // Color textColor=AppColors.darkBlue;
    return ref.watch(transactionViewmodelProvider).when(
      data: (data) {
        List<TagModel> tagList =
            ref.watch(tagViewmodelProvider).asData?.value ?? [];
        final Map<int, List<TransactionModel>> _mapTransRecToParTag = {};

        //Do data processing here to map object with set
        for (var transaction in data) {
          _mapTransRecToParTag[transaction.parentTagId ?? transaction.tagId] = [
            ..._mapTransRecToParTag[
                    transaction.parentTagId ?? transaction.tagId] ??
                [],
            transaction
          ];
        }
        Map<int, double> key2Val = {};
        _mapTransRecToParTag.forEach((key, value) {
          for (var element in value) {
            double curBalance = key2Val[key] ?? 0;
            key2Val[key] =
                (curBalance += double.parse(element.transactionAmount));
          }
        });
//         var sortedEntries = key2Val.entries.toList()
//           ..sort((a, b) => b.value.compareTo(a.value));
//
//         // Take only the top 5 entries
//         var top5Entries = sortedEntries.take(5);

        // Iterate through the top 5 entries and add them to pieChartDataList
        for (var entry in key2Val.entries) {
          pieChartDataList.add(pieChartData(
            value: entry.value,
            tagId: entry.key,
            color: getColorFromTag(tagId: entry.key, tagList: tagList),
            isTouched: touchedKey == entry.key,
          ));
        }

        return AspectRatio(
          aspectRatio: 1,
          child: Column(
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
                              touchedKey = -1;
                              return;
                            }
                            touchedKey = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 80,
                      startDegreeOffset: 180,
                      sections: pieChartDataList,
                    ),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4, crossAxisCount: 2),
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      IBIcon(tagId: data.elementAt(index).tagId),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data.elementAt(index).title,
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
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
      showTitle: false,
      titleStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize));
}
