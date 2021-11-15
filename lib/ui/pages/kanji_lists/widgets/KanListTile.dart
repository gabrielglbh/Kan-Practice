import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';
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
  const KanListTile({required this.item, required this.onTap, required this.onPopWhenTapped,
    required this.onRemoval
  });

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
        padding: EdgeInsets.only(bottom: 8, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(item.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Text("${"created_label".tr()} ${GeneralUtils.parseDateMilliseconds(context, item.lastUpdated)}",
                style: TextStyle(fontSize: 12))
          ],
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WinRateBarChart(dataSource: [
            BarData(x: StudyModes.writing.mode, y: item.totalWinRateWriting, color: StudyModes.writing.color),
            BarData(x: StudyModes.reading.mode, y: item.totalWinRateReading, color: StudyModes.reading.color),
            BarData(x: StudyModes.recognition.mode, y: item.totalWinRateRecognition, color: StudyModes.recognition.color),
          ])
        ],
      ),
    );
  }

  _createDialogForDeletingKanList(BuildContext context, KanjiList l) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("kan_list_tile_createDialogForDeletingKanList_title".tr()),
        content: Text("kan_list_tile_createDialogForDeletingKanList_content".tr()),
        positiveButtonText: "kan_list_tile_createDialogForDeletingKanList_positive".tr(),
        onPositive: () => onRemoval(),
      )
    );
  }
}
