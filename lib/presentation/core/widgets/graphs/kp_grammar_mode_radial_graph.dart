import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_radial_graph_legend.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPGrammarModeRadialGraph extends StatelessWidget {
  final double definition, grammarPoints;
  final double animationDuration;
  const KPGrammarModeRadialGraph({
    super.key,
    required this.definition,
    required this.grammarPoints,
    this.animationDuration = 1000,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    return SizedBox(
      height: KPSizes.defaultSizeWinRateChart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            child: SfCircularChart(
              series: <CircularSeries>[
                RadialBarSeries<DataFrame, String>(
                  dataSource: List.generate(
                    GrammarModes.values.length,
                    (index) {
                      switch (GrammarModes.values[index]) {
                        case GrammarModes.definition:
                          return DataFrame(
                              x: GrammarModes.definition.mode,
                              y: definition,
                              color: GrammarModes.definition.color);
                        case GrammarModes.grammarPoints:
                          return DataFrame(
                              x: GrammarModes.grammarPoints.mode,
                              y: grammarPoints,
                              color: GrammarModes.grammarPoints.color);
                      }
                    },
                  ),
                  animationDuration: animationDuration,
                  xValueMapper: (DataFrame data, _) => data.x,
                  yValueMapper: (DataFrame data, _) =>
                      data.y == DatabaseConstants.emptyWinRate ? 0 : data.y,
                  pointColorMapper: (DataFrame data, _) => data.color,
                  radius: "100%",
                  innerRadius: "65%",
                  cornerStyle: CornerStyle.bothCurve,
                  gap: "2",
                  useSeriesColor: true,
                  trackOpacity: 0.3,
                  maximumValue: 1,
                )
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: GrammarModes.values.length,
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin12),
              itemBuilder: (context, index) {
                double rate = 0;
                switch (GrammarModes.values[index]) {
                  case GrammarModes.definition:
                    rate = definition;
                    break;
                  case GrammarModes.grammarPoints:
                    rate = grammarPoints;
                    break;
                }

                return KPRadialGraphLegend(
                  rate: rate != DatabaseConstants.emptyWinRate
                      ? rate.getFixedPercentageAsString()
                      : "0%",
                  color: GrammarModes.values[index].color,
                  text: GrammarModes.values[index].mode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
