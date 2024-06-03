import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/alter_specific_data/alter_specific_data_bloc.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_study_mode_radial_graph.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/count_label.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/expanded_elapsed_time_tile.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/spec_bottom_sheet.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tappable_info.dart';

class TestStats extends StatefulWidget {
  final KanPracticeStats stats;
  final bool showGrammar;
  const TestStats({super.key, required this.stats, required this.showGrammar});

  @override
  State<TestStats> createState() => _TestStatsState();
}

class _TestStatsState extends State<TestStats>
    with AutomaticKeepAliveClientMixin {
  late double totalSecondsPerCardMean, totalWinRateMean;

  @override
  void initState() {
    // TODO: Update when adding mode
    totalSecondsPerCardMean =
        (widget.stats.test.testTotalSecondsPerWordWriting +
                widget.stats.test.testTotalSecondsPerWordReading +
                widget.stats.test.testTotalSecondsPerWordRecognition +
                widget.stats.test.testTotalSecondsPerWordListening +
                widget.stats.test.testTotalSecondsPerWordSpeaking +
                widget.stats.test.testTotalSecondsPerPointDefinition +
                widget.stats.test.testTotalSecondsPerPointGrammarPoint) /
            (StudyModes.values.length + GrammarModes.values.length);
    // TODO: Update when adding mode
    totalWinRateMean = (widget.stats.test.testTotalWinRateWriting +
            widget.stats.test.testTotalWinRateReading +
            widget.stats.test.testTotalWinRateRecognition +
            widget.stats.test.testTotalWinRateListening +
            widget.stats.test.testTotalWinRateSpeaking +
            widget.stats.test.testTotalWinRateDefinition +
            widget.stats.test.testTotalWinRateGrammarPoint) /
        (StudyModes.values.length + GrammarModes.values.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        StatsHeader(title: "stats_tests_total_acc".tr()),
        CountLabel(
          count: "${totalWinRateMean.getFixedDouble()}%",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
          child: !widget.showGrammar
              ? KPStudyModeRadialGraph(
                  animationDuration: 0,
                  writing: widget.stats.test.testTotalWinRateWriting,
                  reading: widget.stats.test.testTotalWinRateReading,
                  recognition: widget.stats.test.testTotalWinRateRecognition,
                  listening: widget.stats.test.testTotalWinRateListening,
                  speaking: widget.stats.test.testTotalWinRateSpeaking,
                )
              : KPGrammarModeRadialGraph(
                  animationDuration: 0,
                  definition: widget.stats.test.testTotalWinRateDefinition,
                  grammarPoints: widget.stats.test.testTotalWinRateGrammarPoint,
                ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin12),
          child: ListTileTheme(
            dense: true,
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                  iconColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.primary,
                  tilePadding: const EdgeInsets.all(2),
                  title: Text(
                      "${totalSecondsPerCardMean.getFixedDouble()}${"test_time_per_card_card".tr()}",
                      style: Theme.of(context).textTheme.titleLarge),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.showGrammar
                          ? GrammarModes.values.length
                          : StudyModes.values.length,
                      itemBuilder: (context, index) {
                        if (widget.showGrammar) {
                          return _elapsedTimeForGrammarModeExpandedTile(
                              widget.stats.test, GrammarModes.values[index]);
                        }
                        return _elapsedTimeForStudyModeExpandedTile(
                            widget.stats.test, StudyModes.values[index]);
                      },
                    )
                  ]),
            ),
          ),
        ),
        const Divider(),
        StatsHeader(
          title: "stats_tests".tr(),
          value: widget.stats.test.totalTests.toString(),
        ),
        // TODO: update indexes DataFrame when adding mode
        KPBarChart(
          graphName: "tests".tr(),
          animationDuration: 0,
          dataSource: List.generate(
              StudyModes.values.length + GrammarModes.values.length, (index) {
            if (index == 0) {
              final v = widget.stats.test.testTotalCountWriting;
              return DataFrame(
                x: StudyModes.writing.mode,
                y: v.toDouble(),
                color: StudyModes.writing.color,
              );
            } else if (index == 1) {
              final v = widget.stats.test.testTotalCountReading;
              return DataFrame(
                x: StudyModes.reading.mode,
                y: v.toDouble(),
                color: StudyModes.reading.color,
              );
            } else if (index == 2) {
              final v = widget.stats.test.testTotalCountRecognition;
              return DataFrame(
                x: StudyModes.recognition.mode,
                y: v.toDouble(),
                color: StudyModes.recognition.color,
              );
            } else if (index == 3) {
              final v = widget.stats.test.testTotalCountListening;
              return DataFrame(
                x: StudyModes.listening.mode,
                y: v.toDouble(),
                color: StudyModes.listening.color,
              );
            } else if (index == 4) {
              final v = widget.stats.test.testTotalCountSpeaking;
              return DataFrame(
                x: StudyModes.speaking.mode,
                y: v.toDouble(),
                color: StudyModes.speaking.color,
              );
            } else if (index == 5) {
              final v = widget.stats.test.testTotalCountDefinition;
              return DataFrame(
                x: GrammarModes.definition.mode,
                y: v.toDouble(),
                color: GrammarModes.definition.color,
              );
            } else {
              final v = widget.stats.test.testTotalCountGrammarPoint;
              return DataFrame(
                x: GrammarModes.grammarPoints.mode,
                y: v.toDouble(),
                color: GrammarModes.grammarPoints.color,
              );
            }
          }),
        ),
        const Divider(),
        StatsHeader(title: "stats_tests_by_type".tr()),
        KPTappableInfo(text: "stats_tests_tap_to_specs".tr()),
        _expandedTestCount(context, widget.stats),
        const SizedBox(height: KPMargins.margin32)
      ],
    );
  }

  // TODO: Update BLOC call when a new TEST like Numbers is added
  Widget _expandedTestCount(BuildContext context, KanPracticeStats s) {
    return BlocListener<AlterSpecificDataBloc, AlterSpecificDataState>(
      listener: (context, state) {
        state.mapOrNull(testRetrieved: (t) {
          SpecBottomSheet.show(
              context, t.test.name, widget.showGrammar, null, t);
        });
      },
      child: BlocListener<SpecificDataBloc, SpecificDataState>(
        listener: (context, state) {
          state.mapOrNull(testRetrieved: (t) {
            SpecBottomSheet.show(
                context, t.test.name, widget.showGrammar, t.data, null);
          });
        },
        child: KPBarChart(
          enableTooltip: false,
          isHorizontalChart: true,
          heightRatio: 3,
          animationDuration: 0,
          graphName: "tests".tr(),
          onBarTapped: (model) async {
            if (model.dataPoints?.isNotEmpty == true) {
              final test = Tests.values[model.pointIndex ?? -1];
              if (test == Tests.numbers) {
                context
                    .read<AlterSpecificDataBloc>()
                    .add(AlterSpecificDataEventGatherTest(test: test));
                return;
              }
              context
                  .read<SpecificDataBloc>()
                  .add(SpecificDataEventGatherTest(test: test));
            }
          },
          dataSource: List.generate(Tests.values.length, (index) {
            switch (Tests.values[index]) {
              case Tests.lists:
                return DataFrame(
                  x: Tests.lists.nameAbbr,
                  y: s.test.selectionTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.blitz:
                return DataFrame(
                  x: Tests.blitz.nameAbbr,
                  y: s.test.blitzTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.time:
                return DataFrame(
                  x: Tests.time.nameAbbr,
                  y: s.test.remembranceTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.numbers:
                return DataFrame(
                  x: Tests.numbers.nameAbbr,
                  y: s.test.numberTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.less:
                return DataFrame(
                  x: Tests.less.nameAbbr,
                  y: s.test.lessPctTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.categories:
                return DataFrame(
                  x: Tests.categories.nameAbbr,
                  y: s.test.categoryTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.folder:
                return DataFrame(
                  x: Tests.folder.nameAbbr,
                  y: s.test.folderTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
              case Tests.daily:
                return DataFrame(
                  x: Tests.daily.nameAbbr,
                  y: s.test.dailyTests.toDouble(),
                  color: Theme.of(context).colorScheme.primary,
                );
            }
          }),
        ),
      ),
    );
  }

  Widget _elapsedTimeForStudyModeExpandedTile(TestData data, StudyModes mode) {
    final elapsedTime = (switch (mode) {
      StudyModes.writing => data.testTotalSecondsPerWordWriting,
      StudyModes.reading => data.testTotalSecondsPerWordReading,
      StudyModes.recognition => data.testTotalSecondsPerWordRecognition,
      StudyModes.listening => data.testTotalSecondsPerWordListening,
      StudyModes.speaking => data.testTotalSecondsPerWordSpeaking,
    })
        .getFixedDouble();

    return ExpandedElapsedTimeTile(
      mode: mode.mode,
      elapsedTime: "$elapsedTime${"test_time_per_card_word".tr()}",
    );
  }

  Widget _elapsedTimeForGrammarModeExpandedTile(
      TestData data, GrammarModes mode) {
    final elapsedTime = (switch (mode) {
      GrammarModes.definition => data.testTotalSecondsPerPointDefinition,
      GrammarModes.grammarPoints => data.testTotalSecondsPerPointGrammarPoint,
    })
        .getFixedDouble();

    return ExpandedElapsedTimeTile(
      mode: mode.mode,
      elapsedTime: "$elapsedTime${"test_time_per_card_grammar".tr()}",
    );
  }

  @override
  bool get wantKeepAlive => true;
}
