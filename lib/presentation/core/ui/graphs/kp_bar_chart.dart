import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPBarChart extends StatelessWidget {
  final List<DataFrame> dataSource;
  final void Function(ChartPointDetails)? onBarTapped;
  final bool enableTooltip;
  final double heightRatio;
  final bool isHorizontalChart;
  final ChartAxis? axysType;
  final String tooltip;
  final String graphName;
  final double animationDuration;
  const KPBarChart({
    Key? key,
    required this.dataSource,
    required this.graphName,
    this.enableTooltip = true,
    this.onBarTapped,
    this.heightRatio = 1.7,
    this.isHorizontalChart = false,
    this.axysType,
    this.tooltip = "",
    this.animationDuration = 1000,
  }) : super(key: key);

  bool get _isWinRateChart => tooltip == "%";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: KPMargins.margin8),
      child: SizedBox(
        height: KPSizes.defaultSizeWinRateBarChart * heightRatio,
        width: MediaQuery.of(context).size.width - KPMargins.margin48,
        child: SfCartesianChart(
          tooltipBehavior: TooltipBehavior(enable: enableTooltip),
          primaryXAxis: CategoryAxis(
            labelIntersectAction: AxisLabelIntersectAction.trim,
            isInversed: isHorizontalChart ? true : false,
          ),
          primaryYAxis: axysType,
          onTooltipRender: (tip) {
            tip.text = "${tip.text}$tooltip";
          },
          series: <ChartSeries<DataFrame, String>>[
            !isHorizontalChart
                ? ColumnSeries<DataFrame, String>(
                    animationDuration: animationDuration,
                    name: graphName,
                    dataSource: dataSource,
                    pointColorMapper: (DataFrame data, _) => data.color,
                    xValueMapper: (DataFrame data, _) => data.x,
                    yValueMapper: (DataFrame data, _) =>
                        data.y == DatabaseConstants.emptyWinRate ? 0 : data.y,
                    onPointTap: onBarTapped != null
                        ? (details) {
                            onBarTapped!(details);
                          }
                        : null,
                  )
                : BarSeries<DataFrame, String>(
                    animationDuration: animationDuration,
                    name: graphName,
                    dataSource: dataSource,
                    pointColorMapper: (DataFrame data, _) => data.color,
                    xValueMapper: (DataFrame data, _) => data.x,
                    yValueMapper: (DataFrame data, _) => _isWinRateChart
                        ? data.y == DatabaseConstants.emptyWinRate
                            ? 0
                            : Utils.getFixedPercentage(data.y)
                        : data.y,
                    onPointTap: onBarTapped != null
                        ? (details) {
                            onBarTapped!(details);
                          }
                        : null,
                  )
          ],
        ),
      ),
    );
  }
}
