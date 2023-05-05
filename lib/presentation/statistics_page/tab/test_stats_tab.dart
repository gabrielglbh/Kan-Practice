import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/spec_bottom_sheet.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_tappable_info.dart';

class TestStats extends StatefulWidget {
  final KanPracticeStats stats;
  final bool showGrammar;
  const TestStats({super.key, required this.stats, required this.showGrammar});

  @override
  State<TestStats> createState() => _TestStatsState();
}

class _TestStatsState extends State<TestStats>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        StatsHeader(
          title: "stats_tests".tr(),
          value: widget.stats.test.totalTests.toString(),
        ),
        // TODO: update indexes DataFrame when adding mode
        KPBarChart(
          graphName: "tests".tr(),
          animationDuration: 0,
          dataSource: List.generate(
              StudyModes.values.length + GrammarModes.values.length, (index) {
            if (index == 0) {
              final v = widget.stats.test.testTotalCountWriting;
              return DataFrame(
                x: StudyModes.writing.mode,
                y: v.toDouble(),
                color: StudyModes.writing.color,
              );
            } else if (index == 1) {
              final v = widget.stats.test.testTotalCountReading;
              return DataFrame(
                x: StudyModes.reading.mode,
                y: v.toDouble(),
                color: StudyModes.reading.color,
              );
            } else if (index == 2) {
              final v = widget.stats.test.testTotalCountRecognition;
              return DataFrame(
                x: StudyModes.recognition.mode,
                y: v.toDouble(),
                color: StudyModes.recognition.color,
              );
            } else if (index == 3) {
              final v = widget.stats.test.testTotalCountListening;
              return DataFrame(
                x: StudyModes.listening.mode,
                y: v.toDouble(),
                color: StudyModes.listening.color,
              );
            } else if (index == 4) {
              final v = widget.stats.test.testTotalCountSpeaking;
              return DataFrame(
                x: StudyModes.speaking.mode,
                y: v.toDouble(),
                color: StudyModes.speaking.color,
              );
            } else if (index == 5) {
              final v = widget.stats.test.testTotalCountDefinition;
              return DataFrame(
                x: GrammarModes.definition.mode,
                y: v.toDouble(),
                color: GrammarModes.definition.color,
              );
            } else {
              final v = widget.stats.test.testTotalCountGrammarPoint;
              return DataFrame(
                x: GrammarModes.grammarPoints.mode,
                y: v.toDouble(),
                color: GrammarModes.grammarPoints.color,
              );
            }
          }),
        ),
        const Divider(),
        StatsHeader(title: "stats_tests_by_type".tr()),
        const TappableInfo(),
        _expandedTestCount(context, widget.stats),
        const SizedBox(height: KPMargins.margin32)
      ],
    );
  }

  Widget _expandedTestCount(BuildContext context, KanPracticeStats s) {
    return BlocListener<SpecificDataBloc, SpecificDataState>(
      listener: (context, state) {
        state.mapOrNull(testRetrieved: (t) {
          SpecBottomSheet.show(
              context, t.test.name, widget.showGrammar, t.data);
        });
      },
      child: KPBarChart(
        enableTooltip: false,
        isHorizontalChart: true,
        heightRatio: 3,
        animationDuration: 0,
        graphName: "tests".tr(),
        onBarTapped: (model) async {
          if (model.dataPoints?.isNotEmpty == true) {
            final test = Tests.values[model.pointIndex ?? -1];
            context
                .read<SpecificDataBloc>()
                .add(SpecificDataEventGatherTest(test: test));
          }
        },
        dataSource: List.generate(Tests.values.length, (index) {
          switch (Tests.values[index]) {
            case Tests.lists:
              return DataFrame(
                x: Tests.lists.nameAbbr,
                y: s.test.selectionTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.blitz:
              return DataFrame(
                x: Tests.blitz.nameAbbr,
                y: s.test.blitzTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.time:
              return DataFrame(
                x: Tests.time.nameAbbr,
                y: s.test.remembranceTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.numbers:
              return DataFrame(
                x: Tests.numbers.nameAbbr,
                y: s.test.numberTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.less:
              return DataFrame(
                x: Tests.less.nameAbbr,
                y: s.test.lessPctTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.categories:
              return DataFrame(
                x: Tests.categories.nameAbbr,
                y: s.test.categoryTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.folder:
              return DataFrame(
                x: Tests.folder.nameAbbr,
                y: s.test.folderTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.daily:
              return DataFrame(
                x: Tests.daily.nameAbbr,
                y: s.test.dailyTests.toDouble(),
                color: KPColors.secondaryColor,
              );
            case Tests.translation:
              return DataFrame(
                x: Tests.translation.nameAbbr,
                y: s.test.translationTests.toDouble(),
                color: KPColors.secondaryColor,
              );
          }
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
