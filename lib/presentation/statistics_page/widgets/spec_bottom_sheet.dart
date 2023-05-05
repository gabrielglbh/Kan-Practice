import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/alter_specific_data/alter_specific_data_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/infrastructure/specific_data/specific_data_repository_impl.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_study_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';

class SpecBottomSheet extends StatefulWidget {
  final String title;
  final bool showGrammar;
  final SpecificData? data;
  final AlterSpecificDataTestRetrieved? alterData;
  const SpecBottomSheet({
    Key? key,
    required this.title,
    required this.showGrammar,
    this.data,
    this.alterData,
  }) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test specs
  static Future<String?> show(
    BuildContext context,
    String title,
    bool showGrammar,
    SpecificData? data,
    AlterSpecificDataTestRetrieved? alterData,
  ) async {
    String? resultName;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SpecBottomSheet(
              title: title,
              showGrammar: showGrammar,
              data: data,
              alterData: alterData,
            )).then((value) {
      resultName = value;
    });
    return resultName;
  }

  @override
  State<SpecBottomSheet> createState() => _SpecBottomSheetState();
}

class _SpecBottomSheetState extends State<SpecBottomSheet> {
  late bool _showGrammar;
  late SpecificData? _data;
  late AlterSpecificDataTestRetrieved? _alterData;

  bool get _isCategory =>
      widget.data?.id == SpecificDataRepositoryImpl.categoryId;
  int get _length => _isCategory
      ? StudyModes.values.length
      : StudyModes.values.length + GrammarModes.values.length;

  double _getActualWinRate(double v) =>
      v == DatabaseConstants.emptyWinRate ? 0 : v;

  @override
  void initState() {
    _showGrammar = widget.showGrammar;
    _data = widget.data;
    _alterData = widget.alterData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_data != null) {
      final total = _data!.totalWritingCount +
          _data!.totalReadingCount +
          _data!.totalRecognitionCount +
          _data!.totalListeningCount +
          _data!.totalSpeakingCount +
          _data!.totalDefinitionCount +
          _data!.totalGrammarPointCount;
      final aggregate = _getActualWinRate(_data!.totalWinRateWriting) +
          _getActualWinRate(_data!.totalWinRateReading) +
          _getActualWinRate(_data!.totalWinRateRecognition) +
          _getActualWinRate(_data!.totalWinRateListening) +
          _getActualWinRate(_data!.totalWinRateSpeaking) +
          _getActualWinRate(_data!.totalWinRateDefinition) +
          _getActualWinRate(_data!.totalWinRateGrammarPoint);
      final aggregateWithoutGrammar =
          _getActualWinRate(_data!.totalWinRateWriting) +
              _getActualWinRate(_data!.totalWinRateReading) +
              _getActualWinRate(_data!.totalWinRateRecognition) +
              _getActualWinRate(_data!.totalWinRateListening) +
              _getActualWinRate(_data!.totalWinRateSpeaking);

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
                        // TODO: update indexes DataFrame when adding mode
                        dataSource: List.generate(_length, (index) {
                          if (index == 0) {
                            final v = _data!.totalWritingCount;
                            return DataFrame(
                              x: StudyModes.writing.mode,
                              y: v.toDouble(),
                              color: StudyModes.writing.color,
                            );
                          } else if (index == 1) {
                            final v = _data!.totalReadingCount;
                            return DataFrame(
                              x: StudyModes.reading.mode,
                              y: v.toDouble(),
                              color: StudyModes.reading.color,
                            );
                          } else if (index == 2) {
                            final v = _data!.totalRecognitionCount;
                            return DataFrame(
                              x: StudyModes.recognition.mode,
                              y: v.toDouble(),
                              color: StudyModes.recognition.color,
                            );
                          } else if (index == 3) {
                            final v = _data!.totalListeningCount;
                            return DataFrame(
                              x: StudyModes.listening.mode,
                              y: v.toDouble(),
                              color: StudyModes.listening.color,
                            );
                          } else if (index == 4) {
                            final v = _data!.totalSpeakingCount;
                            return DataFrame(
                              x: StudyModes.speaking.mode,
                              y: v.toDouble(),
                              color: StudyModes.speaking.color,
                            );
                          } else if (index == 5) {
                            final v = _data!.totalDefinitionCount;
                            return DataFrame(
                              x: GrammarModes.definition.mode,
                              y: v.toDouble(),
                              color: GrammarModes.definition.color,
                            );
                          } else {
                            final v = _data!.totalGrammarPointCount;
                            return DataFrame(
                              x: GrammarModes.grammarPoints.mode,
                              y: v.toDouble(),
                              color: GrammarModes.grammarPoints.color,
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
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Flexible(
                          child: StatsHeader(
                            title: "specific_accuracy_label".tr(),
                            align: MainAxisAlignment.center,
                            verticalVisualDensity: -4,
                            value: Utils.getFixedPercentageAsString(
                              (_isCategory
                                      ? aggregateWithoutGrammar
                                      : aggregate) /
                                  _length,
                            ),
                          ),
                        ),
                        if (!_isCategory)
                          Padding(
                            padding: const EdgeInsets.only(
                                right: KPMargins.margin16),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showGrammar = !_showGrammar;
                                });
                              },
                              icon: Icon(_showGrammar
                                  ? ListDetailsType.words.icon
                                  : ListDetailsType.grammar.icon),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: KPMargins.margin24),
                      child: !_showGrammar
                          ? KPStudyModeRadialGraph(
                              animationDuration: 0,
                              writing: _data!.totalWinRateWriting,
                              reading: _data!.totalWinRateReading,
                              recognition: _data!.totalWinRateRecognition,
                              listening: _data!.totalWinRateListening,
                              speaking: _data!.totalWinRateSpeaking,
                            )
                          : KPGrammarModeRadialGraph(
                              animationDuration: 0,
                              definition: _data!.totalWinRateDefinition,
                              grammarPoints: _data!.totalWinRateGrammarPoint,
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

    final total = _alterData!.test == Tests.numbers
        ? _alterData!.data.totalNumberTestCount
        : _alterData!.data.totalTranslationTestCount;
    final aggregate = _getActualWinRate(_alterData!.test == Tests.numbers
        ? _alterData!.data.totalWinRateNumberTest
        : _alterData!.data.totalWinRateTranslationTest);

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
                title: "# ${widget.title}",
                value: null,
                verticalVisualDensity: -4,
                align: MainAxisAlignment.center,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: KPMargins.margin8),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        total.toString(),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: StatsHeader(
                          title: "specific_accuracy_label".tr(),
                          align: MainAxisAlignment.center,
                          verticalVisualDensity: -4,
                          value: Utils.getFixedPercentageAsString(
                            aggregate / _length,
                          ),
                        ),
                      ),
                    ],
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
