import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauge;

class KPRadialGraph extends StatelessWidget {
  final double writing, reading, recognition, listening, speaking;
  final double animationDuration;
  const KPRadialGraph({
    Key? key,
    required this.writing,
    required this.reading,
    required this.recognition,
    required this.listening,
    required this.speaking,
    this.animationDuration = 1000,
  }) : super(key: key);

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

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: KPMargins.margin8,
                        height: KPMargins.margin12,
                        child: gauge.SfRadialGauge(
                          enableLoadingAnimation: false,
                          axes: <gauge.RadialAxis>[
                            gauge.RadialAxis(
                              minimum: 0,
                              maximum: 1,
                              showLabels: false,
                              showTicks: false,
                              startAngle: 270,
                              endAngle: 270,
                              pointers: <gauge.GaugePointer>[
                                gauge.RangePointer(
                                  value: 0.8,
                                  width: 0.5,
                                  color: StudyModes.values[index].color,
                                  cornerStyle: gauge.CornerStyle.bothCurve,
                                  sizeUnit: gauge.GaugeSizeUnit.factor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${StudyModes.values[index].mode}:",
                              style:
                                  const TextStyle(fontSize: KPMargins.margin12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              rate != DatabaseConstants.emptyWinRate
                                  ? Utils.getFixedPercentageAsString(rate)
                                  : "0%",
                              style: TextStyle(
                                  fontSize: KPMargins.margin12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black87
                                      : Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
