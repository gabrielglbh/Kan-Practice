import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/test_history/test_history_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_radial_graph.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/general_utils.dart';
import 'package:kanpractice/presentation/statistics_page/model/stats.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';

class TestHistoryArgs {
  final DateTime firstDate, lastDate;
  final TestFilters testFilters;
  final StudyModeFilters modeFilters;

  const TestHistoryArgs(
    this.firstDate,
    this.lastDate,
    this.testFilters,
    this.modeFilters,
  );
}

class TestHistory extends StatefulWidget {
  final KanPracticeStats stats;
  const TestHistory({super.key, required this.stats});

  @override
  State<TestHistory> createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory>
    with AutomaticKeepAliveClientMixin {
  late DateTime _firstDate, _lastDate;
  TestFilters _testsFilter = TestFilters.all;
  StudyModeFilters _modesFilter = StudyModeFilters.all;

  Future<void> _applyFilters(TestHistoryArgs? filters) async {
    if (filters != null) {
      setState(() {
        _firstDate = filters.firstDate;
        _lastDate = filters.lastDate;
        _testsFilter = filters.testFilters;
        _modesFilter = filters.modeFilters;
      });
      // ignore: use_build_context_synchronously
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
    return BlocBuilder<TestHistoryBloc, TestHistoryState>(
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                    child: StatsHeader(title: "history_tests_header".tr())),
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
                      await _applyFilters(filters);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade500),
                    ),
                    child: Text(
                      "history_tests_filter".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white),
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
                    await _applyFilters(filters);
                  },
                  icon: const Icon(Icons.fullscreen_rounded),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
              child: _body(state),
            ),
            const Divider(),
            StatsHeader(
              title: "stats_tests_total_acc".tr(),
              value: GeneralUtils.getFixedPercentageAsString(
                  widget.stats.test.totalTestAccuracy),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
              child: KPRadialGraph(
                animationDuration: 0,
                writing: widget.stats.test.testTotalWinRateWriting,
                reading: widget.stats.test.testTotalWinRateReading,
                recognition: widget.stats.test.testTotalWinRateRecognition,
                listening: widget.stats.test.testTotalWinRateListening,
                speaking: widget.stats.test.testTotalWinRateSpeaking,
              ),
            ),
            const SizedBox(height: Margins.margin32)
          ],
        ),
      ),
    );
  }

  _body(TestHistoryState state) {
    if (state is TestHistoryStateFailure) {
      return Center(child: Text("test_history_load_failed".tr()));
    } else if (state is TestHistoryStateLoading) {
      return const KPProgressIndicator();
    } else if (state is TestHistoryStateLoaded) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
        child: KPCartesianChart(
          markerThreshold: 30,
          height: CustomSizes.defaultSizeWinRateChart * 3,
          dataSource: List.generate(state.list.length, (index) {
            final test = state.list[index];
            return TestDataFrame(
              x: DateTime.fromMillisecondsSinceEpoch(test.takenDate),
              y: test.testScore,
              studyMode: StudyModes.values[test.studyMode],
              wordsOnTest: test.kanjiInTest,
              mode: Tests.values[test.testMode ?? 0],
            );
          }),
          graphName: "success".tr(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
