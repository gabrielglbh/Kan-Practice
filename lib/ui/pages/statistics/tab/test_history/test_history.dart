import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/widgets/stats_header.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_radial_graph.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class TestHistory extends StatefulWidget {
  final KanPracticeStats s;
  const TestHistory({super.key, required this.s});

  @override
  State<TestHistory> createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory>
    with AutomaticKeepAliveClientMixin {
  late DateTime _firstDate, _lastDate;

  String _parseDate(DateTime date) {
    final format = DateFormat('dd/MM/yyyy');
    return format.format(date);
  }

  Future<void> _showRangePicker() async {
    final dialogColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    late DateTimeRange? range;
    await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: _firstDate, end: _lastDate),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: context.locale,
      helpText: 'date_picker_helper'.tr(),
      fieldStartHintText: 'date_picker_start_hint'.tr(),
      fieldEndHintText: 'date_picker_end_hint'.tr(),
      saveText: 'date_picker_save'.tr(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: CustomColors.secondaryColor,
            splashColor: CustomColors.secondaryColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: CustomColors.secondaryColor,
              onPrimary: dialogColor,
              surface: CustomColors.secondaryColor,
              onSurface: dialogColor,
              secondary: CustomColors.secondaryColor,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) => range = value);
    setState(() {
      _firstDate = range?.start ?? _firstDate;
      _lastDate =
          range?.end.add(const Duration(hours: 23, minutes: 59)) ?? _lastDate;
    });
    // ignore: use_build_context_synchronously
    context
        .read<TestListBloc>()
        .add(TestListEventLoading(initial: _firstDate, last: _lastDate));
  }

  @override
  void initState() {
    final now = DateTime.now();
    final parsedNow = DateTime(now.year, now.month, now.day);
    _firstDate = parsedNow;
    _lastDate = parsedNow.add(const Duration(hours: 23, minutes: 59));
    context
        .read<TestListBloc>()
        .add(TestListEventLoading(initial: _firstDate, last: _lastDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TestListBloc, TestListState>(
      builder: (context, state) => ListView(
        children: [
          StatsHeader(
            title: "${"stats_tests_total_acc".tr()} • ",
            value: GeneralUtils.getFixedPercentageAsString(
                widget.s.test.totalTestAccuracy),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
            child: KPRadialGraph(
              animationDuration: 0,
              writing: widget.s.test.testTotalWinRateWriting,
              reading: widget.s.test.testTotalWinRateReading,
              recognition: widget.s.test.testTotalWinRateRecognition,
              listening: widget.s.test.testTotalWinRateListening,
              speaking: widget.s.test.testTotalWinRateSpeaking,
            ),
          ),
          const Divider(),
          StatsHeader(title: "history_tests_header".tr()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: FittedBox(
              child: TextButton(
                onPressed: () async {
                  await _showRangePicker();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade500),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${_parseDate(_firstDate)} - ${_parseDate(_lastDate)}",
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
            child: _body(state),
          ),
          const SizedBox(height: Margins.margin32)
        ],
      ),
    );
  }

  _body(TestListState state) {
    if (state is TestListStateFailure) {
      return Center(child: Text("test_history_load_failed".tr()));
    } else if (state is TestListStateLoading) {
      return const KPProgressIndicator();
    } else if (state is TestListStateLoaded) {
      if (state.list.isEmpty) {
        return Center(child: Text("test_history_load_failed".tr()));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Margins.margin24),
        child: KPCartesianChart(
          dataSource: List.generate(state.list.length, (index) {
            final test = state.list[index];
            return TestDataFrame(
              x: DateTime.fromMillisecondsSinceEpoch(test.takenDate),
              y: test.testScore,
              studyMode: StudyModesUtil.mapStudyMode(test.studyMode),
              wordsOnTest: test.kanjiInTest,
              mode: TestsUtils.mapTestMode(test.testMode ?? 0),
            );
          }),
          graphName: "success".tr(),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
