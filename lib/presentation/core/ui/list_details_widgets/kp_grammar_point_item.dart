import 'package:flutter/material.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_win_rate_chart.dart';
import 'package:kanpractice/presentation/core/ui/kp_grammar_point_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_markdown.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPGrammarPointItem extends StatelessWidget {
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
    required this.grammarPoint,
    this.onRemoval,
    this.onTap,
    required this.selectedMode,
    required this.index,
    required this.onShowModal,
  }) : super(key: key);

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
        winRate: grammarPoint.winRateDefinition,
        backgroundColor: selectedMode.color,
        size: KPSizes.defaultSizeWinRateChart / 3,
        rateSize: KPFontSizes.fontSize12,
      ),
    );
  }
}
