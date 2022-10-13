import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    const size = CustomSizes.defaultSizeWinRateChart + Margins.margin32;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: SfCircularChart(series: <CircularSeries>[
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
              yValueMapper: (DataFrame data, _) => data.y,
              pointColorMapper: (DataFrame data, _) => data.color,
              radius: "100%",
              innerRadius: "20%",
              cornerStyle: CornerStyle.bothCurve,
              gap: "2",
              useSeriesColor: true,
              trackOpacity: 0.3,
              maximumValue: 1,
            )
          ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: size,
          alignment: Alignment.center,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: StudyModes.values.length,
            shrinkWrap: true,
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
                  Container(
                    width: Margins.margin8,
                    height: Margins.margin12,
                    margin:
                        const EdgeInsets.symmetric(horizontal: Margins.margin8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: StudyModes.values[index].color,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${StudyModes.values[index].mode}:",
                            style: const TextStyle(fontSize: Margins.margin12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            rate != DatabaseConstants.emptyWinRate
                                ? GeneralUtils.getFixedPercentageAsString(rate)
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
    );
  }
}
