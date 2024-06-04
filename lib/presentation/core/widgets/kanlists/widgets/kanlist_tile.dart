import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_study_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class KanlistTile extends StatelessWidget {
  /// [WordList] item to paint as a Tile.
  final WordList item;

  /// Action to perform when tapping on a [WordList], in addition to navigating to word_list_details
  final Function onTap;

  /// Action to perform when removing a [WordList]
  final Function onRemoval;

  /// Tells the widget that [this] is a [WordList] within a Folder
  final bool withinFolder;
  final bool showGrammarGraphs;
  const KanlistTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onRemoval,
    this.withinFolder = false,
    this.showGrammarGraphs = false,
  });

  @override
  Widget build(BuildContext context) {
    final date = item.lastUpdated.parseDateMilliseconds();
    return ListTile(
      onTap: () {
        onTap();
        Navigator.of(context)
            .pushNamed(KanPracticePages.wordListDetailsPage, arguments: item);
      },
      onLongPress: () {
        if (withinFolder) {
          _createDialogForDeletingKanListWithinFolder(context);
        } else {
          _createDialogForDeletingKanList(context);
        }
      },
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(item.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "${"created_label".tr()} $date",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          ],
        ),
      ),
      subtitle: !showGrammarGraphs
          ? KPStudyModeRadialGraph(
              writing: item.totalWinRateWriting,
              reading: item.totalWinRateReading,
              recognition: item.totalWinRateRecognition,
              listening: item.totalWinRateListening,
              speaking: item.totalWinRateSpeaking,
            )
          : KPGrammarModeRadialGraph(
              definition: item.totalWinRateDefinition,
              grammarPoints: item.totalWinRateGrammarPoint,
            ),
    );
  }

  _createDialogForDeletingKanList(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => KPDialog(
              title: Text(
                  "kan_list_tile_createDialogForDeletingKanList_title".tr()),
              content: Text(
                  "kan_list_tile_createDialogForDeletingKanList_content".tr()),
              positiveButtonText:
                  "kan_list_tile_createDialogForDeletingKanList_positive".tr(),
              onPositive: () => onRemoval(),
            ));
  }

  _createDialogForDeletingKanListWithinFolder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => KPDialog(
              title: Text(
                  "kan_list_tile_createDialogForDeletingKanListWithinFolder_title"
                      .tr()),
              content: Text(
                  "kan_list_tile_createDialogForDeletingKanListWithinFolder_content"
                      .tr()),
              positiveButtonText:
                  "kan_list_tile_createDialogForDeletingKanListWithinFolder_positive"
                      .tr(),
              onPositive: () => onRemoval(),
            ));
  }
}
