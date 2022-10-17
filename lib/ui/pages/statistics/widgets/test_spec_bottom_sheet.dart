import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/statistics/widgets/stats_header.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_radial_graph.dart';
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
    final aggregateOfTests = widget.data.totalWinRateWriting +
        widget.data.totalWinRateReading +
        widget.data.totalWinRateRecognition +
        widget.data.totalWinRateListening +
        widget.data.totalWinRateSpeaking;

    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              StatsHeader(
                title: "${widget.mode.name} • ",
                value: numberOfTests.toString(),
                verticalVisualDensity: -4,
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KPBarChart(
                    graphName: "tests".tr(),
                    heightRatio: 1.3,
                    animationDuration: 0,
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
                  StatsHeader(
                    title: "${"specific_test_accuracy_label".tr()} • ",
                    textAlign: TextAlign.center,
                    verticalVisualDensity: -4,
                    value: GeneralUtils.getFixedPercentageAsString(
                        aggregateOfTests / StudyModes.values.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Margins.margin24),
                    child: KPRadialGraph(
                      animationDuration: 0,
                      writing: widget.data.totalWinRateWriting,
                      reading: widget.data.totalWinRateReading,
                      recognition: widget.data.totalWinRateRecognition,
                      listening: widget.data.totalWinRateListening,
                      speaking: widget.data.totalWinRateSpeaking,
                    ),
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
