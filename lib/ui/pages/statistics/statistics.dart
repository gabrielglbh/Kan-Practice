import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/pages/statistics/bloc/stats_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/pages/statistics/tab/list_stats.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/test_history.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_stats.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedTab = 0;
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
                  bloc.read<TestListBloc>().add(TestListEventRemoving()),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => StatisticsBloc()..add(StatisticsEventLoading())),
        BlocProvider(create: (_) => TestListBloc()..add(TestListEventIdle())),
      ],
      child: KPScaffold(
        appBarTitle: "settings_general_statistics".tr(),
        appBarActions: [
          if (_controller.index == _tabs.length - 1)
            BlocBuilder<TestListBloc, TestListState>(
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
      ),
    );
  }

  Widget _body(BuildContext context, StatisticsLoaded state) {
    final KanPracticeStats s = state.stats;
    final mode = VisualizationModeExt.mode(
        StorageManager.readData(StorageManager.kanListGraphVisualization) ??
            VisualizationMode.radialChart);

    return Column(
      children: [
        TabBar(controller: _controller, tabs: _tabs),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [
              ListStats(s: s, mode: mode),
              TestStats(s: s, mode: mode),
              const TestHistory(),
            ],
          ),
        ),
      ],
    );
  }
}
