import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/spec_bottom_sheet.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';

class TestStats extends StatefulWidget {
  final KanPracticeStats stats;
  const TestStats({super.key, required this.stats});

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
        KPBarChart(
          graphName: "tests".tr(),
          animationDuration: 0,
          dataSource: List.generate(StudyModes.values.length, (index) {
            switch (StudyModes.values[index]) {
              case StudyModes.writing:
                final v = widget.stats.test.testTotalCountWriting;
                return DataFrame(
                  x: StudyModes.writing.mode,
                  y: v.toDouble(),
                  color: StudyModes.writing.color,
                );
              case StudyModes.reading:
                final v = widget.stats.test.testTotalCountReading;
                return DataFrame(
                  x: StudyModes.reading.mode,
                  y: v.toDouble(),
                  color: StudyModes.reading.color,
                );
              case StudyModes.recognition:
                final v = widget.stats.test.testTotalCountRecognition;
                return DataFrame(
                  x: StudyModes.recognition.mode,
                  y: v.toDouble(),
                  color: StudyModes.recognition.color,
                );
              case StudyModes.listening:
                final v = widget.stats.test.testTotalCountListening;
                return DataFrame(
                  x: StudyModes.listening.mode,
                  y: v.toDouble(),
                  color: StudyModes.listening.color,
                );
              case StudyModes.speaking:
                final v = widget.stats.test.testTotalCountSpeaking;
                return DataFrame(
                  x: StudyModes.speaking.mode,
                  y: v.toDouble(),
                  color: StudyModes.speaking.color,
                );
            }
          }),
        ),
        const Divider(),
        StatsHeader(title: "stats_tests_by_type".tr()),
        _info,
        _expandedTestCount(context, widget.stats),
        const SizedBox(height: KPMargins.margin32)
      ],
    );
  }

  Widget _expandedTestCount(BuildContext context, KanPracticeStats s) {
    return BlocProvider(
      create: (context) => getIt<SpecificDataBloc>(),
      child: BlocListener<SpecificDataBloc, SpecificDataState>(
        listener: (context, state) {
          if (state is SpecificDataStateGatheredTest) {
            SpecBottomSheet.show(context, state.test.name, state.data);
          }
        },
        child: KPBarChart(
          enableTooltip: false,
          isHorizontalChart: true,
          heightRatio: 2.5,
          animationDuration: 0,
          graphName: "tests".tr(),
          onBarTapped: (model) async {
            if (model.dataPoints?.isNotEmpty == true) {
              final test = Tests.values[model.pointIndex ?? -1];
              getIt<SpecificDataBloc>()
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
            }
          }),
        ),
      ),
    );
  }

  Widget get _info => Padding(
        padding: const EdgeInsets.only(
          left: KPMargins.margin16,
          right: KPMargins.margin16,
          bottom: KPMargins.margin8,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: KPMargins.margin8),
              child: Icon(Icons.info_rounded, size: 16, color: Colors.grey),
            ),
            Flexible(
              child: Text(
                "stats_tests_tap_to_specs".tr(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
