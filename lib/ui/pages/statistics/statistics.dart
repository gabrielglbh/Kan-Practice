import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/utils/general_utils.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/pages/statistics/bloc/stats_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key? key}) : super(key: key);
  final StatisticsBloc _bloc = StatisticsBloc();

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: "settings_general_statistics".tr(),
      child: BlocProvider<StatisticsBloc>(
        create: (_) => _bloc..add(StatisticsEventLoading()),
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

  ListView _body(BuildContext context, StatisticsLoaded state) {
    final KanPracticeStats s = state.stats;
    final mode = VisualizationModeExt.mode(StorageManager.readData(
        StorageManager.kanListGraphVisualization) ?? VisualizationMode.radialChart);

    return ListView(
      children: [
        _header(context, "${"stats_words".tr()} • ", "${s.totalLists} ${"stats_words_lists".tr()}"),
        _countLabel(s.totalKanji.toString()),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin16),
          child: KPDependentGraph(
            mode: mode,
            writing: s.totalWinRateWriting,
            reading: s.totalWinRateReading,
            recognition: s.totalWinRateRecognition,
            listening: s.totalWinRateListening
          )
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("stats_best_list".tr(), textAlign: TextAlign.center, style: const TextStyle(
                    fontWeight: FontWeight.bold
                )),
                subtitle: Text(s.bestList, textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text("stats_worst_list".tr(), textAlign: TextAlign.center, style: const TextStyle(
                  fontWeight: FontWeight.bold
                )),
                subtitle: Text(s.worstList, textAlign: TextAlign.center),
              ),
            )
          ],
        ),
        const Divider(),
        _header(context, "${"stats_tests".tr()} • ", "${GeneralUtils.roundUpAsString(
            GeneralUtils.getFixedDouble(s.test.totalTestAccuracy * 100))}%"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(StudyModes.values.length, (index) {
            switch (StudyModes.values[index]) {
              case StudyModes.writing:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    _fittedText(s.test.testTotalCountWriting.toString())
                  ],
                );
              case StudyModes.reading:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    _fittedText(s.test.testTotalCountReading.toString())
                  ],
                );
              case StudyModes.recognition:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    _fittedText(s.test.testTotalCountRecognition.toString())
                  ],
                );
              case StudyModes.listening:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    _fittedText(s.test.testTotalCountListening.toString())
                  ],
                );
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin16),
          child: _countLabel(s.test.totalTests.toString()),
        ),
        const Divider(),
        _expandedTestCount(s),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          child: KPDependentGraph(
            mode: mode,
            writing: s.test.testTotalWinRateWriting,
            reading: s.test.testTotalWinRateReading,
            recognition: s.test.testTotalWinRateRecognition,
            listening: s.test.testTotalWinRateListening
          )
        ),
        const SizedBox(height: Margins.margin64)
      ],
    );
  }

  ListTile _header(BuildContext context, String title, String value) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: FontSizes.fontSize20, fontWeight: FontWeight.bold
              )
            ),
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: FontSizes.fontSize20
              )
            )
          ]
        ),
      )
    );
  }

  Widget _countLabel(String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
      alignment: Alignment.center,
      child: _fittedText(count, style: const TextStyle(fontSize: FontSizes.fontSize64))
    );
  }

  FittedBox _fittedText(String t, {TextStyle? style}) {
    return FittedBox(fit: BoxFit.contain, child: Text(t, style: style));
  }

  Container _bullet(StudyModes mode) {
    return Container(
      width: Margins.margin8, height: Margins.margin8,
      margin: const EdgeInsets.only(
        right: Margins.margin8, left: Margins.margin8,
        top: Margins.margin4, bottom: Margins.margin4
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: mode.color
      ),
    );
  }

  ListView _expandedTestCount(KanPracticeStats s) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(Tests.values.length, (index) {
        switch (Tests.values[index]) {
          case Tests.lists:
            return _testModeCountContainer(Tests.lists, s.test.selectionTests);
          case Tests.blitz:
            return _testModeCountContainer(Tests.blitz, s.test.blitzTests);
          case Tests.time:
            return _testModeCountContainer(Tests.time, s.test.remembranceTests);
          case Tests.numbers:
            return _testModeCountContainer(Tests.numbers, s.test.numberTests);
          case Tests.less:
            return _testModeCountContainer(Tests.less, s.test.lessPctTests);
          case Tests.categories:
            return _testModeCountContainer(Tests.categories, s.test.categoryTests);
        }
      })
    );
  }

  Widget _testModeCountContainer(Tests t, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
      child: Row(
        children: [
          Icon(t.icon, size: Margins.margin18),
          Padding(
            padding: const EdgeInsets.only(left: Margins.margin8),
            child: Text(t.name, style: const TextStyle(fontSize: FontSizes.fontSize14)),
          ),
          Expanded(child: Container()),
          Text(count.toString(), style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize16))
        ],
      ),
    );
  }
}
