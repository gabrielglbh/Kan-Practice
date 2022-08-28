import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/pages/statistics/bloc/stats_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_vertical_chart.dart';
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
              _tests(context, s, mode),
              _lists(context, s, mode),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _lists(
    BuildContext context,
    KanPracticeStats s,
    VisualizationMode mode,
  ) {
    return ListView(
      children: [
        _header(context, "${"stats_words".tr()} • ",
            "${s.totalLists} ${"stats_words_lists".tr()}"),
        _countLabel(context, s.totalKanji.toString()),
        Padding(
            padding: const EdgeInsets.only(top: Margins.margin16),
            child: KPDependentGraph(
              mode: mode,
              writing: s.totalWinRateWriting,
              reading: s.totalWinRateReading,
              recognition: s.totalWinRateRecognition,
              listening: s.totalWinRateListening,
              speaking: s.totalWinRateSpeaking,
            )),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("stats_best_list".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(s.bestList, textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text("stats_worst_list".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(s.worstList, textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _tests(
    BuildContext context,
    KanPracticeStats s,
    VisualizationMode mode,
  ) {
    return ListView(
      children: [
        _header(
            context, "${"stats_tests".tr()} • ", s.test.totalTests.toString()),
        KPVerticalBarChart(
          dataSource: List.generate(StudyModes.values.length, (index) {
            switch (StudyModes.values[index]) {
              case StudyModes.writing:
                final v = s.test.testTotalCountWriting;
                return VerticalBarData(
                  x: StudyModes.writing.mode,
                  y: v.toDouble(),
                  color: StudyModes.writing.color,
                );
              case StudyModes.reading:
                final v = s.test.testTotalCountReading;
                return VerticalBarData(
                  x: StudyModes.reading.mode,
                  y: v.toDouble(),
                  color: StudyModes.reading.color,
                );
              case StudyModes.recognition:
                final v = s.test.testTotalCountRecognition;
                return VerticalBarData(
                  x: StudyModes.recognition.mode,
                  y: v.toDouble(),
                  color: StudyModes.recognition.color,
                );
              case StudyModes.listening:
                final v = s.test.testTotalCountListening;
                return VerticalBarData(
                  x: StudyModes.listening.mode,
                  y: v.toDouble(),
                  color: StudyModes.listening.color,
                );
              case StudyModes.speaking:
                final v = s.test.testTotalCountSpeaking;
                return VerticalBarData(
                  x: StudyModes.speaking.mode,
                  y: v.toDouble(),
                  color: StudyModes.speaking.color,
                );
            }
          }),
        ),
        const Divider(),
        _header(context, "stats_tests_by_type".tr(), ""),
        _expandedTestCount(context, s),
        const Divider(),
        _header(context, "${"stats_tests_total_acc".tr()} • ",
            "${GeneralUtils.roundUpAsString(GeneralUtils.getFixedDouble(s.test.totalTestAccuracy * 100))}%"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          child: KPDependentGraph(
            mode: mode,
            writing: s.test.testTotalWinRateWriting,
            reading: s.test.testTotalWinRateReading,
            recognition: s.test.testTotalWinRateRecognition,
            listening: s.test.testTotalWinRateListening,
            speaking: s.test.testTotalWinRateSpeaking,
          ),
        ),
        const SizedBox(height: 64)
      ],
    );
  }

  ListTile _header(BuildContext context, String title, String value) {
    return ListTile(
        title: RichText(
      text: TextSpan(children: [
        TextSpan(text: title, style: Theme.of(context).textTheme.headline6),
        TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.normal))
      ]),
    ));
  }

  Widget _countLabel(BuildContext context, String count) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
        alignment: Alignment.center,
        child: _fittedText(context, count,
            style: Theme.of(context).textTheme.headline3));
  }

  FittedBox _fittedText(BuildContext context, String t, {TextStyle? style}) {
    return FittedBox(
        fit: BoxFit.contain,
        child: Text(t, style: style ?? Theme.of(context).textTheme.bodyText1));
  }

  Widget _expandedTestCount(BuildContext context, KanPracticeStats s) {
    return KPVerticalBarChart(
      dataSource: List.generate(Tests.values.length, (index) {
        switch (Tests.values[index]) {
          case Tests.lists:
            return VerticalBarData(
              x: Tests.lists.nameAbbr,
              y: s.test.selectionTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.blitz:
            return VerticalBarData(
              x: Tests.blitz.nameAbbr,
              y: s.test.blitzTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.time:
            return VerticalBarData(
              x: Tests.time.nameAbbr,
              y: s.test.remembranceTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.numbers:
            return VerticalBarData(
              x: Tests.numbers.nameAbbr,
              y: s.test.numberTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.less:
            return VerticalBarData(
              x: Tests.less.nameAbbr,
              y: s.test.lessPctTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.categories:
            return VerticalBarData(
              x: Tests.categories.nameAbbr,
              y: s.test.categoryTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.folder:
            return VerticalBarData(
              x: Tests.folder.nameAbbr,
              y: s.test.folderTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
          case Tests.daily:
            return VerticalBarData(
              x: Tests.daily.nameAbbr,
              y: s.test.dailyTests.toDouble(),
              color: CustomColors.secondaryColor,
            );
        }
      }),
    );
  }
}
