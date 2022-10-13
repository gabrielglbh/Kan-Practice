import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarData {
  final String x;
  final double y;
  final Color color;
  const BarData({
    required this.x,
    required this.y,
    required this.color,
  });
}

class KPBarChart extends StatelessWidget {
  final List<BarData> dataSource;
  final void Function(ChartPointDetails)? onBarTapped;
  final bool enableTooltip;
  final double heightRatio;
  final bool isWinRateChart;
  const KPBarChart({
    Key? key,
    required this.dataSource,
    this.enableTooltip = true,
    this.onBarTapped,
    this.heightRatio = 1.7,
    this.isWinRateChart = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSizes.defaultSizeWinRateBarChart * heightRatio,
      width: MediaQuery.of(context).size.width - Margins.margin48,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: enableTooltip),
        primaryXAxis: CategoryAxis(
          labelIntersectAction: AxisLabelIntersectAction.trim,
          isInversed: isWinRateChart ? true : false,
        ),
        primaryYAxis: isWinRateChart
            ? NumericAxis(maximum: 100, minimum: 0, interval: 20)
            : null,
        series: <ChartSeries<BarData, String>>[
          !isWinRateChart
              ? ColumnSeries<BarData, String>(
                  name: "tests".tr(),
                  dataSource: dataSource,
                  pointColorMapper: (BarData data, _) => data.color,
                  xValueMapper: (BarData data, _) => data.x,
                  yValueMapper: (BarData data, _) => data.y,
                  onPointTap: onBarTapped != null
                      ? (details) {
                          onBarTapped!(details);
                        }
                      : null,
                )
              : BarSeries<BarData, String>(
                  name: "success".tr(),
                  dataSource: dataSource,
                  pointColorMapper: (BarData data, _) => data.color,
                  xValueMapper: (BarData data, _) => data.x,
                  yValueMapper: (BarData data, _) =>
                      GeneralUtils.getFixedPercentage(data.y),
                )
        ],
      ),
    );
  }
}
