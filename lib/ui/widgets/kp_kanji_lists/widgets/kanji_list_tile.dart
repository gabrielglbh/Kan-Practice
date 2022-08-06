import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/folder.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class KanjiListTile extends StatelessWidget {
  /// [KanjiList] item to paint as a Tile.
  final KanjiList item;

  /// Action to perform when tapping on a [KanjiList], in addition to navigating to kanji_list_details
  final Function onTap;

  /// Action to perform when removing a [KanjiList]
  final Function onRemoval;

  /// Mode to show the statistics
  final VisualizationMode mode;

  /// Tells the widget that [this] is a [KanjiList] within a Folder
  final bool withinFolder;
  const KanjiListTile({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onRemoval,
    this.withinFolder = false,
    this.mode = VisualizationMode.radialChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = GeneralUtils.parseDateMilliseconds(context, item.lastUpdated);
    return Card(
      child: ListTile(
        onTap: () {
          onTap();
          Navigator.of(context).pushNamed(KanPracticePages.kanjiListDetailsPage,
              arguments: item);
        },
        onLongPress: () {
          if (withinFolder) {
            _createDialogForDeletingKanListWithinFolder(context);
          } else {
            _createDialogForDeletingKanList(context);
          }
        },
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(item.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5),
              ),
              Text(
                "${"created_label".tr()} $date",
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
        subtitle: KPDependentGraph(
          mode: mode,
          writing: item.totalWinRateWriting,
          reading: item.totalWinRateReading,
          recognition: item.totalWinRateRecognition,
          listening: item.totalWinRateListening,
        ),
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
