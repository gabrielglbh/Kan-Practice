import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/types/study_modes.dart';
import 'package:kanpractice/core/utils/types/visualization_mode.dart';
import 'package:kanpractice/ui/widgets/RadialGraph.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';

class DependentGraph extends StatelessWidget {
  final double writing, reading, recognition, listening;
  final VisualizationMode mode;
  const DependentGraph({
    required this.writing, required this.reading, required this.recognition,
    required this.listening, this.mode = VisualizationMode.radialChart
  });

  @override
  Widget build(BuildContext context) {
    return mode == VisualizationMode.barChart ? _barChart() : RadialGraph(
      rateWriting: writing,
      rateReading: reading,
      rateRecognition: recognition,
      rateListening: listening,
    );
  }

  Widget _barChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WinRateBarChart(dataSource: List.generate(StudyModes.values.length, (index) {
          switch (StudyModes.values[index]) {
            case StudyModes.writing:
              return BarData(x: StudyModes.writing.mode, y: writing, color: StudyModes.writing.color);
            case StudyModes.reading:
              return BarData(x: StudyModes.reading.mode, y: reading, color: StudyModes.reading.color);
            case StudyModes.recognition:
              return BarData(x: StudyModes.recognition.mode, y: recognition, color: StudyModes.recognition.color);
            case StudyModes.listening:
              return BarData(x: StudyModes.listening.mode, y: listening, color: StudyModes.listening.color);
          }
        }))
      ],
    );
  }
}
