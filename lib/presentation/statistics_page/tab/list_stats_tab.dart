import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_study_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/spec_bottom_sheet.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_tappable_info.dart';

class ListStats extends StatefulWidget {
  final KanPracticeStats stats;
  final bool showGrammar;
  const ListStats({super.key, required this.stats, required this.showGrammar});

  @override
  State<ListStats> createState() => _ListStatsState();
}

class _ListStatsState extends State<ListStats>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        StatsHeader(
          title:
              !widget.showGrammar ? "stats_words".tr() : "stats_grammar".tr(),
          value: "${widget.stats.totalLists} ${"stats_words_lists".tr()}",
        ),
        _countLabel(
          context,
          !widget.showGrammar
              ? widget.stats.totalWords.toString()
              : widget.stats.totalGrammar.toString(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: !widget.showGrammar
              ? KPStudyModeRadialGraph(
                  animationDuration: 0,
                  writing: widget.stats.totalWinRateWriting,
                  reading: widget.stats.totalWinRateReading,
                  recognition: widget.stats.totalWinRateRecognition,
                  listening: widget.stats.totalWinRateListening,
                  speaking: widget.stats.totalWinRateSpeaking,
                )
              : KPGrammarModeRadialGraph(
                  animationDuration: 0,
                  definition: widget.stats.totalWinRateDefinition,
                  grammarPoints: widget.stats.totalWinRateGrammarPoint,
                ),
        ),
        const Divider(),
        StatsHeader(title: "words_by_category".tr()),
        const TappableInfo(),
        BlocListener<SpecificDataBloc, SpecificDataState>(
          listener: (context, state) {
            state.mapOrNull(categoryRetrieved: (c) {
              SpecBottomSheet.show(context, c.category.category, false, c.data);
            });
          },
          child: KPBarChart(
            graphName: "word_category_label".tr(),
            animationDuration: 0,
            heightRatio: 3.5,
            enableTooltip: false,
            isHorizontalChart: true,
            onBarTapped: (model) async {
              if (model.dataPoints?.isNotEmpty == true) {
                final category = WordCategory.values[model.pointIndex ?? -1];
                context
                    .read<SpecificDataBloc>()
                    .add(SpecificDataEventGatherCategory(category: category));
              }
            },
            dataSource: List.generate(
              WordCategory.values.length,
              (index) => DataFrame(
                x: WordCategory.values[index].category,
                y: widget.stats.totalCategoryCounts[index].toDouble(),
                color: KPColors.secondaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: KPMargins.margin32 + KPMargins.margin8)
      ],
    );
  }

  Widget _countLabel(BuildContext context, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          count,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
