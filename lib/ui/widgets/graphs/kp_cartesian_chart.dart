import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestDataFrame {
  final DateTime x;
  final double y;
  final Color color;
  final Tests mode;
  final int wordsOnTest;

  const TestDataFrame({
    required this.x,
    required this.y,
    required this.color,
    required this.mode,
    required this.wordsOnTest,
  });
}

class KPCartesianChart<T> extends StatelessWidget {
  final List<TestDataFrame> dataSource;
  final String graphName;
  final DateTimeIntervalType intervalType;
  const KPCartesianChart({
    Key? key,
    required this.dataSource,
    required this.graphName,
    this.intervalType = DateTimeIntervalType.auto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSizes.defaultSizeWinRateBarChart * 4,
      width: MediaQuery.of(context).size.width - Margins.margin48,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
        ),
        primaryXAxis: DateTimeAxis(
          intervalType: intervalType,
          enableAutoIntervalOnZooming: true,
        ),
        onTooltipRender: (tip) {
          tip.text = "${tip.text}%";
        },
        primaryYAxis: NumericAxis(maximum: 100, minimum: 0, interval: 20),
        series: <ChartSeries<TestDataFrame, DateTime>>[
          AreaSeries<TestDataFrame, DateTime>(
              animationDuration: 1000,
              name: graphName,
              dataSource: dataSource,
              enableTooltip: true,
              markerSettings: const MarkerSettings(
                isVisible: true,
                color: Colors.white,
                width: 12,
                height: 12,
              ),
              xValueMapper: (TestDataFrame data, _) => data.x,
              yValueMapper: (TestDataFrame data, _) =>
                  data.y == DatabaseConstants.emptyWinRate
                      ? 0
                      : GeneralUtils.getFixedPercentage(data.y),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4, 1],
                colors: [
                  CustomColors.secondaryDarkerColor,
                  CustomColors.secondaryColor
                ],
              ))
        ],
      ),
    );
  }
}
