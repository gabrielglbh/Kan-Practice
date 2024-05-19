import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/radial_graph_legend.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPStudyModeRadialGraph extends StatelessWidget {
  final double writing, reading, recognition, listening, speaking;
  final double animationDuration;
  const KPStudyModeRadialGraph({
    super.key,
    required this.writing,
    required this.reading,
    required this.recognition,
    required this.listening,
    required this.speaking,
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
                    StudyModes.values.length,
                    (index) {
                      switch (StudyModes.values[index]) {
                        case StudyModes.writing:
                          return DataFrame(
                              x: StudyModes.writing.mode,
                              y: writing,
                              color: StudyModes.writing.color);
                        case StudyModes.reading:
                          return DataFrame(
                              x: StudyModes.reading.mode,
                              y: reading,
                              color: StudyModes.reading.color);
                        case StudyModes.recognition:
                          return DataFrame(
                              x: StudyModes.recognition.mode,
                              y: recognition,
                              color: StudyModes.recognition.color);
                        case StudyModes.listening:
                          return DataFrame(
                              x: StudyModes.listening.mode,
                              y: listening,
                              color: StudyModes.listening.color);
                        case StudyModes.speaking:
                          return DataFrame(
                              x: StudyModes.speaking.mode,
                              y: speaking,
                              color: StudyModes.speaking.color);
                      }
                    },
                  ),
                  animationDuration: animationDuration,
                  xValueMapper: (DataFrame data, _) => data.x,
                  yValueMapper: (DataFrame data, _) =>
                      data.y == DatabaseConstants.emptyWinRate ? 0 : data.y,
                  pointColorMapper: (DataFrame data, _) => data.color,
                  radius: "100%",
                  innerRadius: "20%",
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
              itemCount: StudyModes.values.length,
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin12),
              itemBuilder: (context, index) {
                double rate = 0;
                switch (StudyModes.values[index]) {
                  case StudyModes.writing:
                    rate = writing;
                    break;
                  case StudyModes.reading:
                    rate = reading;
                    break;
                  case StudyModes.recognition:
                    rate = recognition;
                    break;
                  case StudyModes.listening:
                    rate = listening;
                    break;
                  case StudyModes.speaking:
                    rate = speaking;
                    break;
                }

                return RadialGraphLegend(
                  rate: rate,
                  color: StudyModes.values[index].color,
                  text: StudyModes.values[index].mode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
