import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_win_rate_chart.dart';

class KPRadialGraph extends StatelessWidget {
  /// [KanjiList] item to paint as a Tile
  final double rateWriting, rateReading, rateRecognition, rateListening;
  final double height;
  const KPRadialGraph({
    Key? key,
    required this.rateWriting,
    required this.rateReading,
    required this.rateRecognition,
    required this.rateListening,
    this.height = CustomSizes.defaultSizeWinRateChart + Margins.margin32
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _radialChart(height),
        Container(
          width: MediaQuery.of(context).size.width / 2, height: height,
          alignment: Alignment.center,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: StudyModes.values.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2.5
            ),
            itemBuilder: (context, index) {
              double rate = 0;
              switch (StudyModes.values[index]) {
                case StudyModes.writing:
                  rate = rateWriting; break;
                case StudyModes.reading:
                  rate = rateReading; break;
                case StudyModes.recognition:
                  rate = rateRecognition; break;
                case StudyModes.listening:
                  rate = rateListening; break;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Margins.margin8, height: Margins.margin8,
                    margin: const EdgeInsets.only(
                      right: Margins.margin8, left: Margins.margin8, top: Margins.margin4
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, color: StudyModes.values[index].color
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Margins.margin16,
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text("${StudyModes.values[index].mode}:",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          height: Margins.margin16,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: Margins.margin16),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(rate != DatabaseConstants.emptyWinRate
                                ? "${GeneralUtils.roundUpAsString(
                                  GeneralUtils.getFixedDouble(rate*100))}%"
                                : "0%",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black87 : Colors.white
                              ),
                            ),
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

  Widget _radialChart(double height) {
    return SizedBox(
      width: height, height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0, right: 0, top: Margins.margin26, bottom: Margins.margin26,
            child: WinRateChart(
              winRate: rateListening,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.listening.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15, pointerOffset: 0,
            ),
          ),
          Positioned(
            left: 0, right: 0, top: Margins.margin18, bottom: Margins.margin18,
            child: WinRateChart(
              winRate: rateRecognition,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.recognition.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15, pointerOffset: 0,
            ),
          ),
          Positioned(
            left: 0, right: 0, top: Margins.margin10, bottom: Margins.margin10,
            child: WinRateChart(
              winRate: rateReading,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.reading.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15, pointerOffset: 0,
            ),
          ),
          Positioned(
            left: 0, right: 0, top: 0, bottom: 0,
            child: WinRateChart(
              winRate: rateWriting,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.writing.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15, pointerOffset: 0,
            ),
          ),
        ],
      ),
    );
  }
}
