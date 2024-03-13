import 'package:budgetapp/app/app_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key, required this.isExpenses});

  final bool isExpenses;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 20,
        maxY: 3400,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        // lineChartBarData1_2,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style =
        TextStyle(color: AppColors.white, fontWeight: FontWeight.bold);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: const Text(
        't',
        style: style,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.darkBlue.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        color: isExpenses ? AppColors.lightGreen : AppColors.lightRed,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  isExpenses ? AppColors.lightGreen : AppColors.lightRed,
                  Colors.transparent
                ])),
        spots: const [
          FlSpot(1, 2000),
          FlSpot(5, 3440),
          FlSpot(7, 2800),
          FlSpot(20, 2000),
          FlSpot(20, 1800),
        ],
      );

  // LineChartBarData get lineChartBarData1_2 => LineChartBarData(
  //       color: AppColors.lightRed,
  //       barWidth: 2,
  //       isStrokeCapRound: true,
  //       dotData: const FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //           show: true,
  //           gradient: const LinearGradient(
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //               colors: [AppColors.lightRed, Colors.transparent])),
  //       spots: const [
  //         FlSpot(1, 0),
  //         FlSpot(5, 100),
  //         FlSpot(7, 500),
  //         FlSpot(20, 1000),
  //       ],
  //     );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isExpenses;

  @override
  void initState() {
    super.initState();
    isExpenses = true;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: LineChartWidget(isExpenses: isExpenses),
      ),
    );
  }
}
