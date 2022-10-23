import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/infrastructure/specific_data/specific_data_repository_impl.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_radial_graph.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';

class SpecBottomSheet extends StatefulWidget {
  final String title;
  final SpecificData data;
  const SpecBottomSheet({Key? key, required this.title, required this.data})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test specs
  static Future<String?> show(
      BuildContext context, String title, SpecificData data) async {
    String? resultName;
    await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SpecBottomSheet(title: title, data: data))
        .then((value) {
      resultName = value;
    });
    return resultName;
  }

  @override
  State<SpecBottomSheet> createState() => _SpecBottomSheetState();
}

class _SpecBottomSheetState extends State<SpecBottomSheet> {
  bool get _isCategory =>
      widget.data.id == SpecificDataRepositoryImpl.categoryId;

  @override
  Widget build(BuildContext context) {
    final total = widget.data.totalWritingCount +
        widget.data.totalReadingCount +
        widget.data.totalRecognitionCount +
        widget.data.totalListeningCount +
        widget.data.totalSpeakingCount;
    final aggregate = widget.data.totalWinRateWriting +
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
                title: _isCategory ? "# ${widget.title}" : widget.title,
                value: _isCategory ? null : total.toString(),
                verticalVisualDensity: -4,
                align: MainAxisAlignment.center,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isCategory)
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
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: KPMargins.margin8),
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          total.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(
                                  fontSize: KPFontSizes.fontSize32 +
                                      KPFontSizes.fontSize16),
                        ),
                      ),
                    ),
                  StatsHeader(
                    title: "specific_accuracy_label".tr(),
                    align: MainAxisAlignment.center,
                    verticalVisualDensity: -4,
                    value: Utils.getFixedPercentageAsString(
                        aggregate / StudyModes.values.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: KPMargins.margin24),
                    child: KPRadialGraph(
                      animationDuration: 0,
                      writing: widget.data.totalWinRateWriting,
                      reading: widget.data.totalWinRateReading,
                      recognition: widget.data.totalWinRateRecognition,
                      listening: widget.data.totalWinRateListening,
                      speaking: widget.data.totalWinRateSpeaking,
                    ),
                  ),
                  const SizedBox(height: KPMargins.margin24)
                ],
              ),
            ],
          ),
        ]);
      },
    );
  }
}
