import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
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
    return ref.watch(transactionViewmodelProvider).when(
      data: (data) {
        return Container(
          height: 100,
          color: getColorFromHex(
              ref.read(tagViewmodelProvider.notifier).getTagColor(tagId: 1)),
        );
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return Container();
      },
    );
//     return AspectRatio(
//       aspectRatio: 1.8,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: 2,
//               child: PieChart(
//                 PieChartData(
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       setState(() {
//                         if (!event.isInterestedForInteractions ||
//                             pieTouchResponse == null ||
//                             pieTouchResponse.touchedSection == null) {
//                           touchedIndex = -1;
//                           return;
//                         }
//                         touchedIndex = pieTouchResponse
//                             .touchedSection!.touchedSectionIndex;
//                       });
//                     },
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 40,
//                   startDegreeOffset: 180,
//                   sections: [
//                     for (int i = 0; i < temp.length; i++)
//                       pieChartData(
//                           value: 30,
//                           category: temp.elementAt(i),
//                           isTouched: touchedIndex == i),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               for (int i = 0; i <= 4; i++)
//                 if (i < 4)
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           temp.elementAt(i).name,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         // getCategoryIcon(category: temp.elementAt(i)),
//                       ],
//                     ),
//                   ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   '...Others',
//                   style: TextStyle(color: AppColors.offWhiteVariant),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//
  }
}

PieChartSectionData pieChartData(
    {required double value, required String tag, bool isTouched = false}) {
  final fontSize = isTouched ? 25.0 : 16.0;
  final radius = isTouched ? 60.0 : 50.0;
  return PieChartSectionData(
      radius: radius,
      value: value,
      // color: getCategoryColor(category: category),
      titleStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize));
}
