import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/test_history/test_history_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_filters.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes_filters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_study_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';

class TestHistoryArgs {
  final DateTime firstDate, lastDate;
  final TestFilters testFilters;
  final TestModeFilters modeFilters;

  const TestHistoryArgs(
    this.firstDate,
    this.lastDate,
    this.testFilters,
    this.modeFilters,
  );
}

class TestHistory extends StatefulWidget {
  final KanPracticeStats stats;
  final bool showGrammar;
  const TestHistory(
      {super.key, required this.stats, required this.showGrammar});

  @override
  State<TestHistory> createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory>
    with AutomaticKeepAliveClientMixin {
  late DateTime _firstDate, _lastDate;
  TestFilters _testsFilter = TestFilters.all;
  TestModeFilters _modesFilter = TestModeFilters.all;

  void _applyFilters(TestHistoryArgs? filters) {
    if (filters != null) {
      setState(() {
        _firstDate = filters.firstDate;
        _lastDate = filters.lastDate;
        _testsFilter = filters.testFilters;
        _modesFilter = filters.modeFilters;
      });
      context.read<TestHistoryBloc>().add(TestHistoryEventLoading(
            initial: _firstDate,
            last: _lastDate,
            testFilter: _testsFilter,
            modesFilter: _modesFilter,
          ));
    }
  }

  @override
  void initState() {
    final now = DateTime.now();
    final parsedNow = DateTime(now.year, now.month, now.day);
    _firstDate = parsedNow;
    _lastDate = parsedNow.add(const Duration(hours: 23, minutes: 59));
    context
        .read<TestHistoryBloc>()
        .add(TestHistoryEventLoading(initial: _firstDate, last: _lastDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: Update when adding mode
    final mean = (widget.stats.test.testTotalWinRateWriting +
            widget.stats.test.testTotalWinRateReading +
            widget.stats.test.testTotalWinRateRecognition +
            widget.stats.test.testTotalWinRateListening +
            widget.stats.test.testTotalWinRateSpeaking +
            widget.stats.test.testTotalWinRateDefinition +
            widget.stats.test.testTotalWinRateGrammarPoint) /
        (StudyModes.values.length + GrammarModes.values.length);
    return SingleChildScrollView(
      child: Column(
        children: [
          StatsHeader(
            title: "stats_tests_total_acc".tr(),
            value: Utils.getFixedPercentageAsString(mean),
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
                    grammarPoints:
                        widget.stats.test.testTotalWinRateGrammarPoint,
                  ),
          ),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(child: StatsHeader(title: "history_tests_header".tr())),
              FittedBox(
                child: TextButton(
                  onPressed: () async {
                    final filters = await Navigator.of(context).pushNamed(
                      KanPracticePages.historyTestFiltersPage,
                      arguments: TestHistoryArgs(
                        _firstDate,
                        _lastDate,
                        _testsFilter,
                        _modesFilter,
                      ),
                    ) as TestHistoryArgs?;
                    _applyFilters(filters);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(KPColors.midGrey),
                  ),
                  child: Text(
                    "history_tests_filter".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: KPColors.primaryLight),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final filters = await Navigator.pushNamed(
                    context,
                    KanPracticePages.historyTestExpandedPage,
                    arguments: TestHistoryArgs(
                      _firstDate,
                      _lastDate,
                      _testsFilter,
                      _modesFilter,
                    ),
                  ) as TestHistoryArgs?;
                  _applyFilters(filters);
                },
                icon: const Icon(Icons.fullscreen_rounded),
              ),
            ],
          ),
          BlocBuilder<TestHistoryBloc, TestHistoryState>(
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: KPMargins.margin8),
                child: state.maybeWhen(
                  error: () =>
                      Center(child: Text("test_history_load_failed".tr())),
                  loading: () => const KPProgressIndicator(),
                  loaded: (tests) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: KPMargins.margin8),
                    child: KPCartesianChart(
                      markerThreshold: 30,
                      height: KPSizes.defaultSizeWinRateChart * 3,
                      dataSource: List.generate(tests.length, (index) {
                        final test = tests[index];
                        if (test.studyMode == null) {
                          return TestDataFrame(
                            x: DateTime.fromMillisecondsSinceEpoch(
                                test.takenDate),
                            y: test.testScore,
                            grammarMode: GrammarModes.values[test.grammarMode!],
                            wordsOnTest: test.wordsInTest,
                            mode: Tests.values[test.testMode ?? 0],
                          );
                        }
                        return TestDataFrame(
                          x: DateTime.fromMillisecondsSinceEpoch(
                              test.takenDate),
                          y: test.testScore,
                          studyMode: StudyModes.values[test.studyMode!],
                          wordsOnTest: test.wordsInTest,
                          mode: Tests.values[test.testMode ?? 0],
                        );
                      }),
                      graphName: "success".tr(),
                    ),
                  ),
                  orElse: () => const SizedBox(),
                ),
              );
            },
          ),
          const SizedBox(height: KPMargins.margin32)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
