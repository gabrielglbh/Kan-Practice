import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/pages/statistics/widgets/stats_header.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/pages/statistics/widgets/test_spec_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_vertical_chart.dart';

class TestStats extends StatefulWidget {
  final KanPracticeStats s;
  final VisualizationMode mode;
  const TestStats({
    super.key,
    required this.s,
    required this.mode,
  });

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
          title: "${"stats_tests".tr()} • ",
          value: widget.s.test.totalTests.toString(),
        ),
        KPVerticalBarChart(
          dataSource: List.generate(StudyModes.values.length, (index) {
            switch (StudyModes.values[index]) {
              case StudyModes.writing:
                final v = widget.s.test.testTotalCountWriting;
                return VerticalBarData(
                  x: StudyModes.writing.mode,
                  y: v.toDouble(),
                  color: StudyModes.writing.color,
                );
              case StudyModes.reading:
                final v = widget.s.test.testTotalCountReading;
                return VerticalBarData(
                  x: StudyModes.reading.mode,
                  y: v.toDouble(),
                  color: StudyModes.reading.color,
                );
              case StudyModes.recognition:
                final v = widget.s.test.testTotalCountRecognition;
                return VerticalBarData(
                  x: StudyModes.recognition.mode,
                  y: v.toDouble(),
                  color: StudyModes.recognition.color,
                );
              case StudyModes.listening:
                final v = widget.s.test.testTotalCountListening;
                return VerticalBarData(
                  x: StudyModes.listening.mode,
                  y: v.toDouble(),
                  color: StudyModes.listening.color,
                );
              case StudyModes.speaking:
                final v = widget.s.test.testTotalCountSpeaking;
                return VerticalBarData(
                  x: StudyModes.speaking.mode,
                  y: v.toDouble(),
                  color: StudyModes.speaking.color,
                );
            }
          }),
        ),
        const Padding(
          padding: EdgeInsets.only(top: Margins.margin16),
          child: Divider(),
        ),
        StatsHeader(title: "stats_tests_by_type".tr()),
        _info,
        _expandedTestCount(context, widget.s),
        const Padding(
          padding: EdgeInsets.only(top: Margins.margin16),
          child: Divider(),
        ),
        StatsHeader(
          title: "${"stats_tests_total_acc".tr()} • ",
          value:
              "${GeneralUtils.roundUpAsString(GeneralUtils.getFixedDouble(widget.s.test.totalTestAccuracy * 100))}%",
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          child: KPDependentGraph(
            mode: widget.mode,
            writing: widget.s.test.testTotalWinRateWriting,
            reading: widget.s.test.testTotalWinRateReading,
            recognition: widget.s.test.testTotalWinRateRecognition,
            listening: widget.s.test.testTotalWinRateListening,
            speaking: widget.s.test.testTotalWinRateSpeaking,
          ),
        ),
        const SizedBox(height: Margins.margin32)
      ],
    );
  }

  Widget _expandedTestCount(BuildContext context, KanPracticeStats s) {
    return KPVerticalBarChart(
      onBarTapped: (model) async {
        if (model.dataPoints?.isNotEmpty == true) {
          final mode = TestsUtils.mapTestMode(model.pointIndex ?? -1);
          final data = await TestQueries.instance.getSpecificTestData(mode);
          // ignore: use_build_context_synchronously
          TestSpecBottomSheet.show(context, mode, data);
        }
      },
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

  Widget get _info => Padding(
        padding: const EdgeInsets.only(
          left: Margins.margin16,
          right: Margins.margin16,
          bottom: Margins.margin8,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: Margins.margin8),
              child: Icon(Icons.info_rounded, size: 16, color: Colors.grey),
            ),
            Text(
              "stats_tests_tap_to_specs".tr(),
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
