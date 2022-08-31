import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/pages/statistics/bloc/stats_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/pages/statistics/tab/list_stats.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_stats.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: "settings_general_statistics".tr(),
      child: BlocProvider<StatisticsBloc>(
        create: (_) => StatisticsBloc()..add(StatisticsEventLoading()),
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

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.track_changes_rounded)),
              Tab(icon: Icon(Icons.table_rows_rounded)),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              TestStats(s: s, mode: mode),
              ListStats(s: s, mode: mode),
            ]),
          ),
        ],
      ),
    );
  }
}
