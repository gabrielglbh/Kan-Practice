import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';

class TestSpecBottomSheet extends StatefulWidget {
  final Tests mode;
  const TestSpecBottomSheet({Key? key, required this.mode}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test specs
  static Future<String?> show(BuildContext context, Tests mode) async {
    String? resultName;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => TestSpecBottomSheet(mode: mode)).then((value) {
      resultName = value;
    });
    return resultName;
  }

  @override
  State<TestSpecBottomSheet> createState() => _TestSpecBottomSheetState();
}

class _TestSpecBottomSheetState extends State<TestSpecBottomSheet> {
  TestSpecificData _data = TestSpecificData.empty;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getDataOnTest(widget.mode);
    });
    super.initState();
  }

  Future<void> _getDataOnTest(Tests mode) async {
    final raw = await TestQueries.instance.getSpecificTestData(mode);
    setState(() {
      _data = raw;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mode = VisualizationModeExt.mode(
        StorageManager.readData(StorageManager.kanListGraphVisualization) ??
            VisualizationMode.radialChart);

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
                    Text(widget.mode.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6)
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3.5),
                margin: const EdgeInsets.all(Margins.margin8),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            List.generate(StudyModes.values.length, (index) {
                          switch (StudyModes.values[index]) {
                            case StudyModes.writing:
                              return Row(
                                children: [
                                  _bullet(StudyModes.values[index]),
                                  _fittedText(context,
                                      _data.totalWritingCount.toString())
                                ],
                              );
                            case StudyModes.reading:
                              return Row(
                                children: [
                                  _bullet(StudyModes.values[index]),
                                  _fittedText(context,
                                      _data.totalReadingCount.toString())
                                ],
                              );
                            case StudyModes.recognition:
                              return Row(
                                children: [
                                  _bullet(StudyModes.values[index]),
                                  _fittedText(context,
                                      _data.totalReadingCount.toString())
                                ],
                              );
                            case StudyModes.listening:
                              return Row(
                                children: [
                                  _bullet(StudyModes.values[index]),
                                  _fittedText(context,
                                      _data.totalListeningCount.toString())
                                ],
                              );
                            case StudyModes.speaking:
                              return Row(
                                children: [
                                  _bullet(StudyModes.values[index]),
                                  _fittedText(context,
                                      _data.totalSpeakingCount.toString())
                                ],
                              );
                          }
                        }),
                      ),
                    ),
                    Expanded(
                      child: KPDependentGraph(
                        mode: mode,
                        writing: _data.totalWinRateWriting,
                        reading: _data.totalWinRateReading,
                        recognition: _data.totalWinRateRecognition,
                        listening: _data.totalWinRateListening,
                        speaking: _data.totalWinRateSpeaking,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Margins.margin16)
            ],
          ),
        ]);
      },
    );
  }

  FittedBox _fittedText(BuildContext context, String t, {TextStyle? style}) {
    return FittedBox(
        fit: BoxFit.contain,
        child: Text(t, style: style ?? Theme.of(context).textTheme.bodyText1));
  }

  Container _bullet(StudyModes mode) {
    return Container(
      width: Margins.margin8,
      height: Margins.margin8,
      margin: const EdgeInsets.only(
          right: Margins.margin8,
          left: Margins.margin8,
          top: Margins.margin4,
          bottom: Margins.margin4),
      decoration: BoxDecoration(shape: BoxShape.circle, color: mode.color),
    );
  }
}
