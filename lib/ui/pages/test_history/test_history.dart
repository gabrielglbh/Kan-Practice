import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/pages/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_win_rate_chart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class TestHistory extends StatefulWidget {
  const TestHistory({Key? key}) : super(key: key);

  @override
  _TestHistoryState createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory> {
  final ScrollController _scrollController = ScrollController();
  int _loadingTimes = 0;

  _showRemoveTestsDialog(BuildContext bloc) {
    showDialog(
      context: bloc,
      builder: (context) => KPDialog(
        title: Text("test_history_showRemoveTestsDialog_title".tr()),
        content: Text("test_history_showRemoveTestsDialog_content".tr(),
          style: Theme.of(context).textTheme.bodyText1),
        positiveButtonText: "test_history_showRemoveTestsDialog_positive".tr(),
        onPositive: () => bloc.read<TestListBloc>().add(TestListEventRemoving()),
      )
    );
  }

  _addLoadingEvent({int offset = 0}) => BlocProvider.of<TestListBloc>(context)
      .add(TestListEventLoading(offset: offset)
  );

  _scrollListener() {
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      _loadingTimes += 1;
      _addLoadingEvent(offset: _loadingTimes);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
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
    /// BlocProvider is defined at route level in order for the whole context of the
    /// class to be accessible to the provider
    return KPScaffold(
      appBarTitle: "test_history_title".tr(),
      appBarActions: [
        BlocBuilder<TestListBloc, TestListState>(
          builder: (context, state) => IconButton(
            icon: const Icon(Icons.clear_all_rounded),
            onPressed: () => _showRemoveTestsDialog(context),
          ),
        )
      ],
      child: BlocBuilder<TestListBloc, TestListState>(
        builder: (context, state) => _body(state)
      ),
    );
  }

  _body(TestListState state) {
    if (state is TestListStateFailure) {
      return KPEmptyList(
        showTryButton: true,
        onRefresh: () => _addLoadingEvent(),
        message: "test_history_load_failed".tr()
      );
    } else if (state is TestListStateLoading) {
      return const KPProgressIndicator();
    } else if (state is TestListStateLoaded) {
      if (state.list.isEmpty) {
        return KPEmptyList(
          onRefresh: () => _addLoadingEvent(),
          message: "test_history_empty".tr()
        );
      }
      return _testList(state);
    }
    else {
      return Container();
    }
  }

  _testList(TestListStateLoaded state) {
    return ListView.builder(
      key: const PageStorageKey<String>('testListController'),
      controller: _scrollController,
      itemCount: state.list.length,
      itemBuilder: (context, k) {
        Test t = state.list[k];
        StudyModes mode = StudyModesUtil.mapStudyMode(t.studyMode);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
          elevation: 8,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: Margins.margin8, vertical: Margins.margin8),
            onTap: () {},
            title: Text(t.kanjiLists, textAlign: TextAlign.end, overflow: TextOverflow.ellipsis),
            subtitle: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: Margins.margin4),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("${mode.mode} • ${"test_history_testTaken".tr()} "
                      "${GeneralUtils.parseDateMilliseconds(context, t.takenDate)}",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic
                      )
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: Margins.margin4),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("${"market_filter_words".tr()}: ${t.kanjiInTest}",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic
                      )
                    ),
                  ),
                )
              ],
            ),
            leading: WinRateChart(winRate: t.testScore,
                padding: EdgeInsets.zero, rateSize: ChartSize.medium,
                backgroundColor: mode.color),
          ),
        );
      }
    );
  }
}
