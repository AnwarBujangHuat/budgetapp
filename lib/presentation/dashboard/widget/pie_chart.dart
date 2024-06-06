import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/icons/custom_icon.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:budgetapp/presentation/dashboard/utils/dashboard_utils.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IBPieChartWidget extends ConsumerWidget {
  const IBPieChartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(transactionViewmodelProvider).when(
      data: (data) {
        List<TagModel> tagList =
            ref.watch(tagViewmodelProvider).asData?.value ?? [];
        TransactionType transactionType =
            ref.watch(selectedTransactionTypeProvider);

        Map<int, double> groupByTotal = getTotalTransaction(
            transactionList: data, transactionType: transactionType);
        return AspectRatio(
          aspectRatio: 1.8,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                    aspectRatio: 2,
                    child: PieChartWidget(
                      tagList: tagList,
                      groupByTotal: groupByTotal,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4 && i < groupByTotal.length; i++)
                    if (i < 4)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Text(
                              getTagDetail(
                                      tagList: tagList,
                                      tagId: groupByTotal.keys.elementAt(i)) ??
                                  'Transaction',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            IBIcon(tagId: groupByTotal.keys.elementAt(i))
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

      // TODO manage Error when Load Data
      error: (error, stackTrace) {
        return Container();
      },
      // TODO manage Loading
      loading: () {
        return Container();
      },
    );
  }
}

PieChartSectionData pieChartData(
    {required double value, required Color color, bool isTouched = false}) {
  final fontSize = isTouched ? 20.0 : 16.0;
  final radius = isTouched ? 60.0 : 50.0;
  return PieChartSectionData(
      radius: radius,
      value: value,
      color: color,
      showTitle: isTouched,
      titleStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize));
}

class PieChartWidget extends StatefulWidget {
  const PieChartWidget(
      {required this.groupByTotal, required this.tagList, super.key});
  final Map<int, double> groupByTotal;
  final List<TagModel> tagList;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  /// initial load, no transaction is highlighted
  int touchedKey = -1;

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> dataList = [];

    for (int i = 0; i < widget.groupByTotal.length; i++) {
      dataList.add(pieChartData(
        isTouched: touchedKey == i,
        value: widget.groupByTotal.entries.elementAt(i).value,
        color: getColorFromTag(
            tagId: widget.groupByTotal.keys.elementAt(i),
            tagList: widget.tagList),
      ));
    }
    return PieChart(
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
              touchedKey = pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        startDegreeOffset: 180,
        sections: dataList,
      ),
    );
  }
}
