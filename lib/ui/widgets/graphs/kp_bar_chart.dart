import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
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
  }) : super(key: key);

  bool get _isWinRateChart => tooltip == "%";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Margins.margin8),
      child: SizedBox(
        height: CustomSizes.defaultSizeWinRateBarChart * heightRatio,
        width: MediaQuery.of(context).size.width - Margins.margin48,
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
                    animationDuration: 1000,
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
                    animationDuration: 1000,
                    name: graphName,
                    dataSource: dataSource,
                    pointColorMapper: (DataFrame data, _) => data.color,
                    xValueMapper: (DataFrame data, _) => data.x,
                    yValueMapper: (DataFrame data, _) => _isWinRateChart
                        ? data.y == DatabaseConstants.emptyWinRate
                            ? 0
                            : GeneralUtils.getFixedPercentage(data.y)
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
