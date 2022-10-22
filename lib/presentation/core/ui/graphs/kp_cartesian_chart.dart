import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestDataFrame {
  final DateTime x;
  final double y;
  final StudyModes studyMode;
  final Tests mode;
  final int wordsOnTest;

  const TestDataFrame({
    required this.x,
    required this.y,
    required this.studyMode,
    required this.mode,
    required this.wordsOnTest,
  });
}

class KPCartesianChart<T> extends StatelessWidget {
  final List<TestDataFrame> dataSource;
  final String graphName;
  final DateTimeIntervalType intervalType;
  final ZoomPanBehavior? zoomPanBehavior;
  final int markerThreshold;
  final double? height;
  const KPCartesianChart({
    Key? key,
    required this.dataSource,
    required this.graphName,
    this.intervalType = DateTimeIntervalType.auto,
    this.zoomPanBehavior,
    this.markerThreshold = 200,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(
          enable: true,
          builder: ((data, point, series, pointIndex, seriesIndex) =>
              _KPCartesianChartTooltip(
                source: dataSource[pointIndex],
              )),
        ),
        zoomPanBehavior: zoomPanBehavior,
        onMarkerRender: (args) {
          final point = args.pointIndex;
          args.color = point == null ? null : dataSource[point].studyMode.color;
          args.borderWidth = 1;
          args.borderColor = Colors.white;
        },
        primaryXAxis: DateTimeAxis(
          intervalType: intervalType,
          enableAutoIntervalOnZooming: true,
        ),
        primaryYAxis: NumericAxis(maximum: 120, minimum: 0, interval: 20),
        series: <ChartSeries<TestDataFrame, DateTime>>[
          LineSeries<TestDataFrame, DateTime>(
            animationDuration: 0,
            name: graphName,
            dataSource: dataSource,
            enableTooltip: true,
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Colors.white,
              width: dataSource.length > markerThreshold ? 9 : 14,
              height: dataSource.length > markerThreshold ? 9 : 14,
            ),
            xValueMapper: (TestDataFrame data, _) => data.x,
            yValueMapper: (TestDataFrame data, _) =>
                data.y == DatabaseConstants.emptyWinRate
                    ? 0
                    : Utils.getFixedPercentage(data.y),
            color: KPColors.secondaryColor,
          )
        ],
      ),
    );
  }
}

class _KPCartesianChartTooltip extends StatelessWidget {
  final TestDataFrame source;
  const _KPCartesianChartTooltip({
    Key? key,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tooltipColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    final tooltipTextColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black;
    final format = DateFormat('MMM dd, HH:mm');
    final mode = source.mode.nameAbbr;
    final date = format.format(source.x);
    final rate = Utils.getFixedPercentageAsString(source.y);
    return Container(
      padding: const EdgeInsets.all(KPMargins.margin8),
      decoration: BoxDecoration(
        color: tooltipColor,
        borderRadius: BorderRadius.circular(KPRadius.radius8),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: source.studyMode.color,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: KPMargins.margin4),
                Text(source.studyMode.mode,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: tooltipTextColor)),
                const SizedBox(width: KPMargins.margin4),
                Text(mode,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: tooltipTextColor, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: KPMargins.margin8),
            Container(width: 128, height: 1, color: tooltipTextColor),
            const SizedBox(height: KPMargins.margin8),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: KPMargins.margin4),
                    child: Text("$date:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: tooltipTextColor)),
                  ),
                  Text(rate,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: tooltipTextColor, fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
