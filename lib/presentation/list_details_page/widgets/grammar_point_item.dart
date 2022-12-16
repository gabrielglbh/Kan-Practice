import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_win_rate_chart.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class GrammarPointItem extends StatelessWidget {
  final bool aggregateStats;
  final String listName;
  final WordList list;
  final GrammarPoint grammarPoint;
  final GrammarModes selectedMode;
  final Function() onRemoval;
  final Function() onTap;
  final int index;
  final Function() onShowModal;
  const GrammarPointItem({
    Key? key,
    this.aggregateStats = false,
    required this.listName,
    required this.grammarPoint,
    required this.list,
    required this.onRemoval,
    required this.onTap,
    required this.selectedMode,
    required this.index,
    required this.onShowModal,
  }) : super(key: key);

  double _getProperGrammarPointWinRate(GrammarPoint grammarPoint) {
    if (aggregateStats) {
      final definition =
          (grammarPoint.winRateDefinition == DatabaseConstants.emptyWinRate
              ? 0
              : grammarPoint.winRateDefinition);
      final recognition =
          (grammarPoint.winRateRecognition == DatabaseConstants.emptyWinRate
              ? 0
              : grammarPoint.winRateRecognition);

      final aggregate = definition + recognition;
      if (aggregate == 0) return -1;
      return aggregate / GrammarModes.values.length;
    }

    switch (selectedMode) {
      case GrammarModes.definition:
        return grammarPoint.winRateDefinition;
      case GrammarModes.recognition:
        return grammarPoint.winRateRecognition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        onShowModal();
        // TODO: Grammar details bottom sheet
        /*await KPKanjiBottomSheet.show(context, listName, kanji,
            onTap: onTap, onRemove: onRemoval);*/
      },
      title: Text(
        grammarPoint.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "• ${grammarPoint.definition}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: WinRateChart(
        winRate: _getProperGrammarPointWinRate(grammarPoint),
        backgroundColor:
            aggregateStats ? KPColors.secondaryColor : selectedMode.color,
        size: KPSizes.defaultSizeWinRateChart / 3,
        rateSize: KPFontSizes.fontSize12,
      ),
    );
  }
}
