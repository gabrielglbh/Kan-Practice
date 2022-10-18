import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/test_history.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
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

  Future<void> _applyFilters(BuildContext blocContext) async {
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
      // ignore: use_build_context_synchronously
      blocContext.read<TestListBloc>().add(TestListEventLoading(
            initial: _firstDate,
            last: _lastDate,
            testFilter: _testsFilter,
            modesFilter: _modesFilter,
          ));
    }
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
            padding: const EdgeInsets.all(Margins.margin8),
            child: BlocProvider<TestListBloc>(
              create: (_) => TestListBloc()
                ..add(TestListEventLoading(
                  initial: _firstDate,
                  last: _lastDate,
                  testFilter: _testsFilter,
                  modesFilter: _modesFilter,
                )),
              child: BlocBuilder<TestListBloc, TestListState>(
                builder: (blocContext, state) {
                  if (state is TestListStateFailure) {
                    return Center(child: Text("test_history_load_failed".tr()));
                  } else if (state is TestListStateLoading) {
                    return const KPProgressIndicator();
                  } else if (state is TestListStateLoaded) {
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
                              studyMode:
                                  StudyModesUtil.mapStudyMode(test.studyMode),
                              wordsOnTest: test.kanjiInTest,
                              mode: TestsUtils.mapTestMode(test.testMode ?? 0),
                            );
                          }),
                          graphName: "success".tr(),
                        ),
                        Positioned(
                          top: 0,
                          right: Margins.margin64,
                          child: TextButton(
                            onPressed: () async {
                              await _applyFilters(blocContext);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade500),
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
                        Positioned(
                          top: 0,
                          right: Margins.margin8,
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
      ),
    );
  }
}
