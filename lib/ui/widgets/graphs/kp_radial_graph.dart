import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauge;

class KPRadialGraph extends StatelessWidget {
  final double rateWriting,
      rateReading,
      rateRecognition,
      rateListening,
      rateSpeaking;
  const KPRadialGraph({
    Key? key,
    required this.rateWriting,
    required this.rateReading,
    required this.rateRecognition,
    required this.rateListening,
    required this.rateSpeaking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 3;
    return SizedBox(
      height: CustomSizes.defaultSizeWinRateChart,
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
                              y: rateWriting,
                              color: StudyModes.writing.color);
                        case StudyModes.reading:
                          return DataFrame(
                              x: StudyModes.reading.mode,
                              y: rateReading,
                              color: StudyModes.reading.color);
                        case StudyModes.recognition:
                          return DataFrame(
                              x: StudyModes.recognition.mode,
                              y: rateRecognition,
                              color: StudyModes.recognition.color);
                        case StudyModes.listening:
                          return DataFrame(
                              x: StudyModes.listening.mode,
                              y: rateListening,
                              color: StudyModes.listening.color);
                        case StudyModes.speaking:
                          return DataFrame(
                              x: StudyModes.speaking.mode,
                              y: rateSpeaking,
                              color: StudyModes.speaking.color);
                      }
                    },
                  ),
                  animationDuration: 1000,
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
              padding: const EdgeInsets.only(right: Margins.margin12),
              itemBuilder: (context, index) {
                double rate = 0;
                switch (StudyModes.values[index]) {
                  case StudyModes.writing:
                    rate = rateWriting;
                    break;
                  case StudyModes.reading:
                    rate = rateReading;
                    break;
                  case StudyModes.recognition:
                    rate = rateRecognition;
                    break;
                  case StudyModes.listening:
                    rate = rateListening;
                    break;
                  case StudyModes.speaking:
                    rate = rateSpeaking;
                    break;
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: Margins.margin8,
                        height: Margins.margin12,
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
                                  const TextStyle(fontSize: Margins.margin12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              rate != DatabaseConstants.emptyWinRate
                                  ? GeneralUtils.getFixedPercentageAsString(
                                      rate)
                                  : "0%",
                              style: TextStyle(
                                  fontSize: Margins.margin12,
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
