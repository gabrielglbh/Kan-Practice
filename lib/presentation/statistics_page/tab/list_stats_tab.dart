import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/specific_data/specific_data_bloc.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_bar_chart.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_data_frame.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_radial_graph.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/domain/stats/stats.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/spec_bottom_sheet.dart';
import 'package:kanpractice/presentation/statistics_page/widgets/stats_header.dart';

class ListStats extends StatefulWidget {
  final KanPracticeStats stats;
  const ListStats({super.key, required this.stats});

  @override
  State<ListStats> createState() => _ListStatsState();
}

class _ListStatsState extends State<ListStats>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final boldTheme = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(fontWeight: FontWeight.bold);
    return ListView(
      children: [
        StatsHeader(
          title: "stats_words".tr(),
          value: "${widget.stats.totalLists} ${"stats_words_lists".tr()}",
        ),
        _countLabel(context, widget.stats.totalWords.toString()),
        Padding(
            padding: const EdgeInsets.only(top: KPMargins.margin16),
            child: KPRadialGraph(
              animationDuration: 0,
              writing: widget.stats.totalWinRateWriting,
              reading: widget.stats.totalWinRateReading,
              recognition: widget.stats.totalWinRateRecognition,
              listening: widget.stats.totalWinRateListening,
              speaking: widget.stats.totalWinRateSpeaking,
            )),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("stats_best_list".tr(),
                    textAlign: TextAlign.center, style: boldTheme),
                subtitle:
                    Text(widget.stats.bestList, textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text("stats_worst_list".tr(),
                    textAlign: TextAlign.center, style: boldTheme),
                subtitle:
                    Text(widget.stats.worstList, textAlign: TextAlign.center),
              ),
            )
          ],
        ),
        const Divider(),
        StatsHeader(title: "words_by_category".tr()),
        BlocProvider(
          create: (context) => getIt<SpecificDataBloc>(),
          child: BlocListener<SpecificDataBloc, SpecificDataState>(
            listener: (context, state) {
              if (state is SpecificDataStateGatheredCategory) {
                SpecBottomSheet.show(
                  context,
                  state.category.category,
                  state.data,
                );
              }
            },
            child: KPBarChart(
              graphName: "kanji_category_label".tr(),
              animationDuration: 0,
              heightRatio: 3,
              enableTooltip: false,
              isHorizontalChart: true,
              onBarTapped: (model) async {
                if (model.dataPoints?.isNotEmpty == true) {
                  final category = WordCategory.values[model.pointIndex ?? -1];
                  getIt<SpecificDataBloc>()
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
        ),
        const SizedBox(height: KPMargins.margin32)
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
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}