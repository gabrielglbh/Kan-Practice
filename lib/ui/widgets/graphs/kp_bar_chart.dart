import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPBarChart extends StatelessWidget {
  final List<DataFrame> dataSource;
  final void Function(ChartPointDetails)? onBarTapped;
  final bool enableTooltip;
  final double heightRatio;
  final bool isWinRateChart;
  final String graphName;
  const KPBarChart({
    Key? key,
    required this.dataSource,
    required this.graphName,
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
        series: <ChartSeries<DataFrame, String>>[
          !isWinRateChart
              ? ColumnSeries<DataFrame, String>(
                  animationDuration: 1000,
                  name: graphName,
                  dataSource: dataSource,
                  pointColorMapper: (DataFrame data, _) => data.color,
                  xValueMapper: (DataFrame data, _) => data.x,
                  yValueMapper: (DataFrame data, _) => data.y,
                  onPointTap: onBarTapped != null
                      ? (details) {
                          onBarTapped!(details);
                        }
                      : null,
                )
              : BarSeries<DataFrame, String>(
                  animationDuration: 1000,
                  name: "success".tr(),
                  dataSource: dataSource,
                  pointColorMapper: (DataFrame data, _) => data.color,
                  xValueMapper: (DataFrame data, _) => data.x,
                  yValueMapper: (DataFrame data, _) =>
                      GeneralUtils.getFixedPercentage(data.y),
                )
        ],
      ),
    );
  }
}
