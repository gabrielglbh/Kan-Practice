import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/pages/statistics/widgets/stats_header.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';

class ListStats extends StatefulWidget {
  final KanPracticeStats s;
  final VisualizationMode mode;
  const ListStats({
    super.key,
    required this.s,
    required this.mode,
  });

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
          title: "${"stats_words".tr()} • ",
          value: "${widget.s.totalLists} ${"stats_words_lists".tr()}",
        ),
        _countLabel(context, widget.s.totalKanji.toString()),
        Padding(
            padding: const EdgeInsets.only(top: Margins.margin16),
            child: KPDependentGraph(
              mode: widget.mode,
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
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(widget.s.bestList, textAlign: TextAlign.center),
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
                subtitle: Text(widget.s.worstList, textAlign: TextAlign.center),
              ),
            )
          ],
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
