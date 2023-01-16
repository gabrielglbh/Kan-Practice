import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_win_rate_chart.dart';
import 'package:kanpractice/presentation/core/widgets/kp_grammar_point_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPGrammarPointItem extends StatelessWidget {
  final bool aggregateStats;
  final String? listName;
  final GrammarPoint grammarPoint;
  final GrammarModes selectedMode;
  final Function()? onRemoval;
  final Function()? onTap;
  final int index;
  final Function() onShowModal;
  const KPGrammarPointItem({
    Key? key,
    this.listName,
    this.aggregateStats = false,
    required this.grammarPoint,
    this.onRemoval,
    this.onTap,
    required this.selectedMode,
    required this.index,
    required this.onShowModal,
  }) : super(key: key);

  double _getProperGpWinRate(GrammarPoint gp) {
    if (aggregateStats) {
      final definition = (gp.winRateDefinition == DatabaseConstants.emptyWinRate
          ? 0
          : gp.winRateDefinition);
      final grammarPoints =
          (gp.winRateGrammarPoint == DatabaseConstants.emptyWinRate
              ? 0
              : gp.winRateGrammarPoint);

      final aggregate = definition + grammarPoints;
      if (aggregate == 0) return -1;
      return aggregate / GrammarModes.values.length;
    }

    switch (selectedMode) {
      case GrammarModes.definition:
        return gp.winRateDefinition;
      case GrammarModes.grammarPoints:
        return gp.winRateGrammarPoint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        onShowModal();
        await KPGrammarPointBottomSheet.show(context, listName, grammarPoint,
            onTap: onTap, onRemove: onRemoval);
      },
      title: Padding(
        padding: const EdgeInsets.only(bottom: KPMargins.margin4),
        child: KPMarkdown(data: grammarPoint.name, type: MarkdownType.body),
      ),
      subtitle: KPMarkdown(
        data: grammarPoint.definition,
        type: MarkdownType.body,
      ),
      trailing: WinRateChart(
        winRate: _getProperGpWinRate(grammarPoint),
        backgroundColor:
            aggregateStats ? KPColors.secondaryColor : selectedMode.color,
        size: KPSizes.defaultSizeWinRateChart / 3,
        rateSize: KPFontSizes.fontSize12,
      ),
    );
  }
}
