import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VerticalBarData {
  final String x;
  final double y;
  final Color color;
  const VerticalBarData({
    required this.x,
    required this.y,
    required this.color,
  });
}

class KPVerticalBarChart extends StatelessWidget {
  final List<VerticalBarData> dataSource;
  final void Function(ChartPointDetails)? onBarTapped;
  final double heightRatio;
  const KPVerticalBarChart({
    Key? key,
    required this.dataSource,
    this.onBarTapped,
    this.heightRatio = 1.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSizes.defaultSizeWinRateBarChart * heightRatio,
      width: MediaQuery.of(context).size.width - Margins.margin48,
      child: SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: onBarTapped == null),
        primaryXAxis: CategoryAxis(
          labelIntersectAction: AxisLabelIntersectAction.trim,
        ),
        series: <ChartSeries<VerticalBarData, String>>[
          ColumnSeries<VerticalBarData, String>(
            name: "tests".tr(),
            dataSource: dataSource,
            pointColorMapper: (VerticalBarData data, _) => data.color,
            xValueMapper: (VerticalBarData data, _) => data.x,
            yValueMapper: (VerticalBarData data, _) => data.y,
            onPointTap: onBarTapped != null
                ? (details) {
                    onBarTapped!(details);
                  }
                : null,
          )
        ],
      ),
    );
  }
}
