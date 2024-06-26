import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPBarChart extends StatelessWidget {
  final List<DataFrame> dataSource;
  final void Function(ChartPointDetails)? onBarTapped;
  final bool enableTooltip;
  final double heightRatio;
  final bool isHorizontalChart;
  final String tooltip;
  final String graphName;
  final double animationDuration;
  const KPBarChart({
    super.key,
    required this.dataSource,
    required this.graphName,
    this.enableTooltip = true,
    this.onBarTapped,
    this.heightRatio = 1.7,
    this.isHorizontalChart = false,
    this.tooltip = "",
    this.animationDuration = 1000,
  });

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
            isVisible: isHorizontalChart ? true : false,
            isInversed: isHorizontalChart ? true : false,
          ),
          onTooltipRender: (tip) {
            tip.text = "${tip.text}$tooltip";
          },
          series: <CartesianSeries<DataFrame, String>>[
            !isHorizontalChart
                ? ColumnSeries<DataFrame, String>(
                    animationDuration: animationDuration,
                    name: graphName,
                    dataSource: dataSource,
                    pointColorMapper: (DataFrame data, _) => data.color,
                    dataLabelSettings: DataLabelSettings(
                      builder: ((data, point, series, pointIndex, seriesIndex) {
                        if (pointIndex == 0) {
                          return Icon(
                            StudyModes.writing.icon,
                            size: 18,
                            color: StudyModes.writing.color,
                          );
                        } else if (pointIndex == 1) {
                          return Icon(
                            StudyModes.reading.icon,
                            size: 18,
                            color: StudyModes.reading.color,
                          );
                        } else if (pointIndex == 2) {
                          return Icon(
                            StudyModes.recognition.icon,
                            size: 18,
                            color: StudyModes.recognition.color,
                          );
                        } else if (pointIndex == 3) {
                          return Icon(
                            StudyModes.listening.icon,
                            size: 18,
                            color: StudyModes.listening.color,
                          );
                        } else if (pointIndex == 4) {
                          return Icon(
                            StudyModes.speaking.icon,
                            size: 18,
                            color: StudyModes.speaking.color,
                          );
                        } else if (pointIndex == 5) {
                          return Icon(
                            GrammarModes.definition.icon,
                            size: 18,
                            color: GrammarModes.definition.color,
                          );
                        } else {
                          return Icon(
                            GrammarModes.grammarPoints.icon,
                            size: 18,
                            color: GrammarModes.grammarPoints.color,
                          );
                        }
                      }),
                      isVisible: true,
                    ),
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
                            : data.y.getFixedPercentage()
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
