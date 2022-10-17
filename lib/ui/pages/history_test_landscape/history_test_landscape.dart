import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryTestExpandedArgs {
  final DateTime firstDate, lastDate;

  const HistoryTestExpandedArgs(this.firstDate, this.lastDate);
}

class HistoryTestExpanded extends StatefulWidget {
  final HistoryTestExpandedArgs data;
  const HistoryTestExpanded({super.key, required this.data});

  @override
  State<HistoryTestExpanded> createState() => _HistoryTestExpandedState();
}

class _HistoryTestExpandedState extends State<HistoryTestExpanded> {
  late DateTime _firstDate, _lastDate;

  @override
  void initState() {
    _firstDate = widget.data.firstDate;
    _lastDate = widget.data.lastDate;
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

  Future<void> _showRangePicker(BuildContext blocContext) async {
    DateTimeRange? range =
        await GeneralUtils.showRangeTimeDialog(context, _firstDate, _lastDate);
    setState(() {
      _firstDate = range?.start ?? _firstDate;
      _lastDate =
          range?.end.add(const Duration(hours: 23, minutes: 59)) ?? _lastDate;
    });
    // ignore: use_build_context_synchronously
    blocContext
        .read<TestListBloc>()
        .add(TestListEventLoading(initial: _firstDate, last: _lastDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Margins.margin8),
          child: BlocProvider<TestListBloc>(
            create: (_) => TestListBloc()
              ..add(TestListEventLoading(initial: _firstDate, last: _lastDate)),
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
                        right: Margins.margin24,
                        child: TextButton(
                          onPressed: () async {
                            await _showRangePicker(blocContext);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey.shade500),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${GeneralUtils.parseDate(_firstDate)} - ${GeneralUtils.parseDate(_lastDate)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(color: Colors.white),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: Margins.margin8),
                                child: Icon(
                                  Icons.expand_more_rounded,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: Margins.margin32,
                        right: Margins.margin24,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.fullscreen_exit_rounded,
                            color: CustomColors.secondaryColor,
                          ),
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
