import 'package:flutter/material.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_win_rate_chart.dart';
import 'package:kanpractice/presentation/core/ui/kp_grammar_point_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_markdown.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class GrammarPointOnTestList extends StatelessWidget {
  final Map<String, List<Map<GrammarPoint, double>>>? list;
  final GrammarModes mode;
  const GrammarPointOnTestList({
    super.key,
    required this.list,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: ListView.builder(
        itemCount: list?.keys.toList().length,
        itemBuilder: (context, index) {
          String? listName = list?.keys.toList()[index];
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: KPMargins.margin8),
                child: Text("$listName (${list?[listName]?.length}):",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list?[listName]?.length ?? 0,
                itemBuilder: (context, inner) {
                  GrammarPoint gp =
                      list?[listName]?[inner].keys.first ?? GrammarPoint.empty;
                  double testScore = list?[listName]?[inner].values.first ?? 0;
                  return ListTile(
                    onTap: () async {
                      await KPGrammarPointBottomSheet.show(
                          context, gp.listName, gp);
                    },
                    title: KPMarkdown(
                      data: gp.name,
                      type: MarkdownType.body,
                    ),
                    trailing: WinRateChart(
                      winRate: testScore,
                      backgroundColor: mode.color,
                      size: KPSizes.defaultSizeWinRateChart / 3,
                      rateSize: KPFontSizes.fontSize12,
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
