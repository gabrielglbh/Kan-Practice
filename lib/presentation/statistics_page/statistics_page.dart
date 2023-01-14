import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/statistics/stats_bloc.dart';
import 'package:kanpractice/application/test_history/test_history_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/statistics_page/tab/list_stats_tab.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_history_tab/test_history_tab.dart';
import 'package:kanpractice/presentation/statistics_page/tab/test_stats_tab.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedTab = 0;
  bool _showGrammarGraphs = false;
  final _tabs = const [
    Tab(icon: Icon(Icons.table_rows_rounded)),
    Tab(icon: Icon(Icons.track_changes_rounded)),
    Tab(icon: Icon(Icons.history_rounded)),
  ];

  _showRemoveTestsDialog(BuildContext bloc) {
    showDialog(
        context: bloc,
        builder: (context) => KPDialog(
              title: Text("test_history_showRemoveTestsDialog_title".tr()),
              content: Text("test_history_showRemoveTestsDialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyText1),
              positiveButtonText:
                  "test_history_showRemoveTestsDialog_positive".tr(),
              onPositive: () =>
                  getIt<TestHistoryBloc>().add(TestHistoryEventRemoving()),
            ));
  }

  _changedTab() {
    setState(() {
      _selectedTab = _controller.index;
    });
  }

  @override
  void initState() {
    _controller = TabController(
        initialIndex: _selectedTab, length: _tabs.length, vsync: this);
    _controller.addListener(_changedTab);
    getIt<StatisticsBloc>().add(StatisticsEventLoading());
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_changedTab);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: "settings_general_statistics".tr(),
      appBarActions: [
        IconButton(
          icon: Icon(
            _showGrammarGraphs
                ? ListDetailsType.words.icon
                : ListDetailsType.grammar.icon,
          ),
          onPressed: () {
            setState(() => _showGrammarGraphs = !_showGrammarGraphs);
          },
        ),
        if (_controller.index == _tabs.length - 1)
          BlocBuilder<TestHistoryBloc, TestHistoryState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.clear_all_rounded),
                onPressed: () => _showRemoveTestsDialog(context),
              );
            },
          ),
      ],
      child: BlocBuilder<StatisticsBloc, StatsState>(
        builder: (context, state) {
          if (state is StatisticsLoaded) {
            return _body(context, state);
          } else if (state is StatisticsLoading) {
            return const KPProgressIndicator();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _body(BuildContext context, StatisticsLoaded state) {
    final KanPracticeStats stats = state.stats;

    return Column(
      children: [
        TabBar(controller: _controller, tabs: _tabs),
        const SizedBox(height: KPMargins.margin16),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [
              ListStats(stats: stats, showGrammar: _showGrammarGraphs),
              TestStats(stats: stats),
              TestHistory(stats: stats, showGrammar: _showGrammarGraphs),
            ],
          ),
        ),
      ],
    );
  }
}
