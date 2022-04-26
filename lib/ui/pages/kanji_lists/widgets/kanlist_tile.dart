import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/general_utils.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class KanListTile extends StatelessWidget {
  /// [KanjiList] item to paint as a Tile
  final KanjiList item;
  /// Action to perform when returning from the kanji_list_details
  final Function onPopWhenTapped;
  /// Action to perform when tapping on a [KanjiList], in addition to navigating to kanji_list_details
  final Function onTap;
  /// Action to perform when removing a [KanjiList]
  final Function onRemoval;
  /// Mode to show the statistics
  final VisualizationMode mode;
  const KanListTile({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onPopWhenTapped,
    required this.onRemoval,
    this.mode = VisualizationMode.radialChart
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        onTap();
        await Navigator.of(context).pushNamed(KanPracticePages.kanjiListDetailsPage, arguments: item)
            .then((_) => onPopWhenTapped());
      },
      onLongPress: () => _createDialogForDeletingKanList(context, item),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(item.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
            ),
            Text("${"created_label".tr()} ${GeneralUtils.parseDateMilliseconds(context, item.lastUpdated)}",
                style: const TextStyle(fontSize: FontSizes.fontSize12))
          ],
        ),
      ),
      subtitle: KPDependentGraph(
        mode: mode,
        writing: item.totalWinRateWriting,
        reading: item.totalWinRateReading,
        recognition: item.totalWinRateRecognition,
        listening: item.totalWinRateListening
      )
    );
  }

  _createDialogForDeletingKanList(BuildContext context, KanjiList l) {
    showDialog(
      context: context,
      builder: (context) => KPDialog(
        title: Text("kan_list_tile_createDialogForDeletingKanList_title".tr()),
        content: Text("kan_list_tile_createDialogForDeletingKanList_content".tr()),
        positiveButtonText: "kan_list_tile_createDialogForDeletingKanList_positive".tr(),
        onPositive: () => onRemoval(),
      )
    );
  }
}