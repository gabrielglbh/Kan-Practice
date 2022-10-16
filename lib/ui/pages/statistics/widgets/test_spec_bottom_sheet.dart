import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';

class TestSpecBottomSheet extends StatefulWidget {
  final Tests mode;
  final TestSpecificData data;
  const TestSpecBottomSheet({Key? key, required this.mode, required this.data})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test specs
  static Future<String?> show(
      BuildContext context, Tests mode, TestSpecificData data) async {
    String? resultName;
    await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => TestSpecBottomSheet(mode: mode, data: data))
        .then((value) {
      resultName = value;
    });
    return resultName;
  }

  @override
  State<TestSpecBottomSheet> createState() => _TestSpecBottomSheetState();
}

class _TestSpecBottomSheetState extends State<TestSpecBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final numberOfTests = widget.data.totalWritingCount +
        widget.data.totalReadingCount +
        widget.data.totalRecognitionCount +
        widget.data.totalListeningCount +
        widget.data.totalSpeakingCount;

    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Margins.margin8),
                      child: Icon(widget.mode.icon),
                    ),
                    Text("${widget.mode.name} • $numberOfTests",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6)
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KPBarChart(
                    graphName: "tests".tr(),
                    heightRatio: 1.3,
                    dataSource:
                        List.generate(StudyModes.values.length, (index) {
                      switch (StudyModes.values[index]) {
                        case StudyModes.writing:
                          return DataFrame(
                            x: StudyModes.writing.mode,
                            y: widget.data.totalWritingCount.toDouble(),
                            color: StudyModes.writing.color,
                          );
                        case StudyModes.reading:
                          return DataFrame(
                            x: StudyModes.reading.mode,
                            y: widget.data.totalReadingCount.toDouble(),
                            color: StudyModes.reading.color,
                          );
                        case StudyModes.recognition:
                          return DataFrame(
                            x: StudyModes.recognition.mode,
                            y: widget.data.totalRecognitionCount.toDouble(),
                            color: StudyModes.recognition.color,
                          );
                        case StudyModes.listening:
                          return DataFrame(
                            x: StudyModes.listening.mode,
                            y: widget.data.totalListeningCount.toDouble(),
                            color: StudyModes.listening.color,
                          );
                        case StudyModes.speaking:
                          return DataFrame(
                            x: StudyModes.speaking.mode,
                            y: widget.data.totalSpeakingCount.toDouble(),
                            color: StudyModes.speaking.color,
                          );
                      }
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("specific_test_accuracy_label".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  KPDependentGraph(
                    mode: VisualizationModeExt.mode(StorageManager.readData(
                            StorageManager.kanListGraphVisualization) ??
                        VisualizationMode.radialChart),
                    writing: widget.data.totalWinRateWriting,
                    reading: widget.data.totalWinRateReading,
                    recognition: widget.data.totalWinRateRecognition,
                    listening: widget.data.totalWinRateListening,
                    speaking: widget.data.totalWinRateSpeaking,
                  ),
                  const SizedBox(height: Margins.margin16)
                ],
              ),
            ],
          ),
        ]);
      },
    );
  }
}
