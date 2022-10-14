import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_cartesian_chart.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TestHistory extends StatefulWidget {
  const TestHistory({Key? key}) : super(key: key);

  @override
  State<TestHistory> createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _loadingTimes = 0;

  _addLoadingEvent({int offset = 0}) =>
      context.read<TestListBloc>().add(TestListEventLoading(offset: offset));

  _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      _loadingTimes += 1;
      _addLoadingEvent(offset: _loadingTimes);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    context.read<TestListBloc>().add(const TestListEventLoading());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TestListBloc, TestListState>(
      builder: (context, state) => _body(state),
    );
  }

  _body(TestListState state) {
    if (state is TestListStateFailure) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(),
          message: "test_history_load_failed".tr());
    } else if (state is TestListStateLoading) {
      return const KPProgressIndicator();
    } else if (state is TestListStateLoaded) {
      if (state.list.isEmpty) {
        return KPEmptyList(
            onRefresh: () => _addLoadingEvent(),
            message: "test_history_empty".tr());
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Margins.margin12),
        child: _testList(state),
      );
    } else {
      return Container();
    }
  }

  _testList(TestListStateLoaded state) {
    final keys = state.list.keys.toList();
    return ListView.builder(
      key: const PageStorageKey<String>('testListController'),
      controller: _scrollController,
      itemCount: state.list.length,
      itemBuilder: (context, k) {
        final tests = state.list[keys[k]] ?? [];
        return ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          tilePadding: const EdgeInsets.all(0),
          iconColor: CustomColors.secondaryColor,
          initiallyExpanded: k == 0,
          title: Text(
            "${"stats_test_from".tr()} ${keys[k]} (${tests.length})",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          children: [
            KPCartesianChart(
              intervalType: DateTimeIntervalType.hours,
              dataSource: List.generate(
                tests.length,
                (index) => TestDataFrame(
                  x: DateTime.fromMillisecondsSinceEpoch(
                      tests[index].takenDate),
                  y: tests[index].testScore,
                  color:
                      StudyModesUtil.mapStudyMode(tests[index].studyMode).color,
                  wordsOnTest: tests[index].kanjiInTest,
                  mode: TestsUtils.mapTestMode(tests[index].testMode ?? 0),
                ),
              ),
              graphName: keys[k],
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
