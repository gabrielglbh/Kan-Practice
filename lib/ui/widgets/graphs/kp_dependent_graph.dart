import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_radial_graph.dart';

class KPDependentGraph extends StatelessWidget {
  final double writing, reading, recognition, listening, speaking;
  final VisualizationMode mode;
  const KPDependentGraph(
      {Key? key,
      required this.writing,
      required this.reading,
      required this.recognition,
      required this.listening,
      required this.speaking,
      this.mode = VisualizationMode.radialChart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mode == VisualizationMode.barChart
        ? _barChart()
        : KPRadialGraph(
            rateWriting: writing,
            rateReading: reading,
            rateRecognition: recognition,
            rateListening: listening,
            rateSpeaking: speaking,
          );
  }

  Widget _barChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: KPBarChart(
            isWinRateChart: true,
            heightRatio: 1.2,
            dataSource: List.generate(
              StudyModes.values.length,
              (index) {
                switch (StudyModes.values[index]) {
                  case StudyModes.writing:
                    return BarData(
                        x: StudyModes.writing.mode,
                        y: writing,
                        color: StudyModes.writing.color);
                  case StudyModes.reading:
                    return BarData(
                        x: StudyModes.reading.mode,
                        y: reading,
                        color: StudyModes.reading.color);
                  case StudyModes.recognition:
                    return BarData(
                        x: StudyModes.recognition.mode,
                        y: recognition,
                        color: StudyModes.recognition.color);
                  case StudyModes.listening:
                    return BarData(
                        x: StudyModes.listening.mode,
                        y: listening,
                        color: StudyModes.listening.color);
                  case StudyModes.speaking:
                    return BarData(
                        x: StudyModes.speaking.mode,
                        y: speaking,
                        color: StudyModes.speaking.color);
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
