import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/pages/statistics/widgets/stats_header.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_bar_chart.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_data_frame.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_radial_graph.dart';

class ListStats extends StatefulWidget {
  final KanPracticeStats s;
  const ListStats({super.key, required this.s});

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
          title: "${"stats_words".tr()} • ",
          value: "${widget.s.totalLists} ${"stats_words_lists".tr()}",
        ),
        _countLabel(context, widget.s.totalKanji.toString()),
        Padding(
            padding: const EdgeInsets.only(top: Margins.margin16),
            child: KPRadialGraph(
              writing: widget.s.totalWinRateWriting,
              reading: widget.s.totalWinRateReading,
              recognition: widget.s.totalWinRateRecognition,
              listening: widget.s.totalWinRateListening,
              speaking: widget.s.totalWinRateSpeaking,
            )),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("stats_best_list".tr(),
                    textAlign: TextAlign.center, style: boldTheme),
                subtitle: Text(widget.s.bestList, textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text("stats_worst_list".tr(),
                    textAlign: TextAlign.center, style: boldTheme),
                subtitle: Text(widget.s.worstList, textAlign: TextAlign.center),
              ),
            )
          ],
        ),
        const Divider(),
        StatsHeader(title: "words_by_category".tr()),
        KPBarChart(
          graphName: "kanji_category_label".tr(),
          heightRatio: 3,
          isHorizontalChart: true,
          dataSource: List.generate(
            KanjiCategory.values.length,
            (index) => DataFrame(
              x: KanjiCategory.values[index].category,
              y: widget.s.totalCategoryCounts[index].toDouble(),
              color: CustomColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _countLabel(BuildContext context, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
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
