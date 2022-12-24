import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/test_history/test_history_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes_filters.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes_filters.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_tab.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestHistoryExpanded extends StatefulWidget {
  final TestHistoryArgs data;
  const TestHistoryExpanded({super.key, required this.data});

  @override
  State<TestHistoryExpanded> createState() => _TestHistoryExpandedState();
}

class _TestHistoryExpandedState extends State<TestHistoryExpanded> {
  late DateTime _firstDate, _lastDate;
  TestFilters _testsFilter = TestFilters.all;
  StudyModeFilters _modesFilter = StudyModeFilters.all;

  @override
  void initState() {
    _firstDate = widget.data.firstDate;
    _lastDate = widget.data.lastDate;
    _testsFilter = widget.data.testFilters;
    _modesFilter = widget.data.modeFilters;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future<void> _applyFilters() async {
    final filters = await Navigator.of(context).pushNamed(
      KanPracticePages.historyTestFiltersPage,
      arguments: TestHistoryArgs(
        _firstDate,
        _lastDate,
        _testsFilter,
        _modesFilter,
      ),
    ) as TestHistoryArgs?;
    if (filters != null) {
      setState(() {
        _firstDate = filters.firstDate;
        _lastDate = filters.lastDate;
        _testsFilter = filters.testFilters;
        _modesFilter = filters.modeFilters;
      });
      getIt<TestHistoryBloc>().add(TestHistoryEventLoading(
        initial: _firstDate,
        last: _lastDate,
        testFilter: _testsFilter,
        modesFilter: _modesFilter,
      ));
    }
    getIt<TestHistoryBloc>().add(TestHistoryEventLoading(
      initial: _firstDate,
      last: _lastDate,
      testFilter: _testsFilter,
      modesFilter: _modesFilter,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(
          TestHistoryArgs(_firstDate, _lastDate, _testsFilter, _modesFilter),
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(KPMargins.margin8),
            child: BlocBuilder<TestHistoryBloc, TestHistoryState>(
              builder: (blocContext, state) {
                if (state is TestHistoryStateFailure) {
                  return Center(child: Text("test_history_load_failed".tr()));
                } else if (state is TestHistoryStateLoading) {
                  return const KPProgressIndicator();
                } else if (state is TestHistoryStateLoaded) {
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      KPCartesianChart(
                        markerThreshold: 150,
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePanning: true,
                          enablePinching: true,
                          maximumZoomLevel: 0.3,
                        ),
                        dataSource: List.generate(state.list.length, (index) {
                          final test = state.list[index];
                          return TestDataFrame(
                            x: DateTime.fromMillisecondsSinceEpoch(
                                test.takenDate),
                            y: test.testScore,
                            studyMode: StudyModes.values[test.studyMode ?? 0],
                            wordsOnTest: test.wordsInTest,
                            mode: Tests.values[test.testMode ?? 0],
                          );
                        }),
                        graphName: "success".tr(),
                      ),
                      Positioned(
                        top: 0,
                        right: KPMargins.margin64,
                        child: TextButton(
                          onPressed: () async {
                            await _applyFilters();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(KPColors.midGrey),
                          ),
                          child: Text(
                            "history_tests_filter".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: KPColors.primaryLight),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: KPMargins.margin8,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                              TestHistoryArgs(_firstDate, _lastDate,
                                  _testsFilter, _modesFilter),
                            );
                          },
                          icon: const Icon(Icons.fullscreen_exit_rounded),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
