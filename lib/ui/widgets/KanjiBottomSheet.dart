import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/TTSIconButton.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';
import 'package:easy_localization/easy_localization.dart';

class KanjiBottomSheet extends StatelessWidget {
  /// Kanji object to be displayed
  final String listName;
  final Kanji? kanji;
  final Function()? onRemove;
  final Function()? onTap;
  const KanjiBottomSheet({required this.listName, required this.kanji,
    this.onTap, this.onRemove
  });

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected kanji
  static Future<String?> callKanjiModeBottomSheet(BuildContext context,
      String listName, Kanji? kanji, {Function()? onRemove, Function()? onTap}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KanjiBottomSheet(
        listName: listName,
        kanji: kanji,
        onTap: onTap,
        onRemove: onRemove
      )
    );
  }

  _createDialogForDeletingKanji(BuildContext context, Kanji? k) {
    if (k != null) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: Text("kanji_bottom_sheet_removeKanji_title".tr()),
          content: Text("kanji_bottom_sheet_removeKanji_content".tr()),
          positiveButtonText: "kanji_bottom_sheet_removeKanji_positive".tr(),
          onPositive: () async {
            final int code = await KanjiQueries.instance.removeKanji(listName, k.kanji);
            if (code == 0) {
              KanjiList kanList = await ListQueries.instance.getList(listName);
              List<Kanji> list = await KanjiQueries.instance.getAllKanjiFromList(listName);
              /// Update for each mode the overall score again. Issue: #10
              ///
              /// For each mode, recalculate the overall score based on the
              /// winRates of the value to be deleted and the new KanList length.
              /// It takes into account the empty values.
              ///
              /// If list is empty, update all values to -1.
              if (list.isEmpty) {
                await ListQueries.instance.updateList(listName, {
                  KanListTableFields.totalWinRateWritingField: DatabaseConstants.emptyWinRate,
                  KanListTableFields.totalWinRateReadingField: DatabaseConstants.emptyWinRate,
                  KanListTableFields.totalWinRateRecognitionField: DatabaseConstants.emptyWinRate
                });
              } else {
                double wNewScore = kanList.totalWinRateWriting;
                double readNewScore = kanList.totalWinRateReading;
                double recNewScore = kanList.totalWinRateRecognition;

                if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
                  /// Get the y value: total length of list prior to removal of
                  /// kanji multiplied by the overall win rate
                  double y = (list.length + 1) * kanList.totalWinRateWriting;
                  /// Subtract the winRate of the removed kanji to y
                  double partialScore = y - k.winRateWriting;
                  /// Calculate the new overall score with the partialScore divided
                  /// by the list without the kanji
                  wNewScore = partialScore / list.length;
                }
                if (k.winRateReading != DatabaseConstants.emptyWinRate) {
                  double y = (list.length + 1) * kanList.totalWinRateReading;
                  double partialScore = y - k.winRateReading;
                  readNewScore = partialScore / list.length;
                }
                if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
                  double y = (list.length + 1) * kanList.totalWinRateRecognition;
                  double partialScore = y - k.winRateRecognition;
                  recNewScore = partialScore / list.length;
                }

                await ListQueries.instance.updateList(listName, {
                  KanListTableFields.totalWinRateWritingField: wNewScore,
                  KanListTableFields.totalWinRateReadingField: readNewScore,
                  KanListTableFields.totalWinRateRecognitionField: recNewScore
                });
              }
              if (onRemove != null) onRemove!();
            }
            else if (code == 1)
              GeneralUtils.getSnackBar(context, "kanji_bottom_sheet_createDialogForDeletingKanji_removal_failed".tr());
            else
              GeneralUtils.getSnackBar(context, "kanji_bottom_sheet_createDialogForDeletingKanji_failed".tr());
          }
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Container(
              margin: EdgeInsets.all(Margins.margin8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DragContainer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu_book_rounded),
                          onPressed: () {
                            Navigator.of(context).pushNamed(KanPracticePages.jishoPage, arguments: kanji?.kanji);
                          },
                        ),
                        Container(
                          height: Margins.margin24,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(kanji?.pronunciation ?? "wildcard".tr(), textAlign: TextAlign.center,
                                style: TextStyle(fontSize: FontSizes.fontSize16)),
                          ),
                        ),
                        TTSIconButton(kanji: kanji?.kanji)
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(kanji?.kanji ?? "wildcard".tr(), textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize32)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin16),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(kanji?.meaning ?? "wildcard".tr(), textAlign: TextAlign.center,
                          style: TextStyle(fontSize: FontSizes.fontSize16))
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CustomRadius.radius16)),
                    margin: EdgeInsets.only(bottom: Margins.margin16, top: Margins.margin8),
                    child: ListTile(
                      title: WinRateBarChart(dataSource: [
                        BarData(x: StudyModes.writing.mode,
                            y: (kanji?.winRateWriting ?? DatabaseConstants.emptyWinRate),
                            color: StudyModes.writing.color),
                        BarData(x: StudyModes.reading.mode,
                            y: (kanji?.winRateReading ?? DatabaseConstants.emptyWinRate),
                            color: StudyModes.reading.color),
                        BarData(x: StudyModes.recognition.mode,
                            y: (kanji?.winRateRecognition ?? DatabaseConstants.emptyWinRate),
                            color: StudyModes.recognition.color),
                      ])
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Margins.margin8, right: Margins.margin8, bottom: Margins.margin16
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text("${"created_label".tr()} "
                          "${GeneralUtils.parseDateMilliseconds(context, (kanji?.dateAdded ?? 0))}",
                          textAlign: TextAlign.center, style: TextStyle(fontSize: FontSizes.fontSize14))
                    ),
                  ),
                  Visibility(
                    visible: onTap != null && onRemove != null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Divider(),
                        _actionButtons(context),
                      ],
                    ),
                  ),
                ]
              ),
            ),
          ]
        );
      },
    );
  }

  Container _actionButtons(BuildContext context) {
    return Container(
      height: CustomSizes.actionButtonsKanjiDetail,
      child: Column(
        children: [
          ListTile(
            title: Text("kanji_bottom_sheet_removal_label".tr()),
            trailing: Icon(Icons.clear),
            onTap: () {
              Navigator.of(context).pop();
              _createDialogForDeletingKanji(context, kanji);
            },
          ),
          Divider(),
          ListTile(
            title: Text("kanji_bottom_sheet_update_label".tr()),
            trailing: Icon(Icons.arrow_forward_rounded),
            onTap: () {
              Navigator.of(context).pop();
              if (onTap != null) onTap!();
            },
          )
        ],
      ),
    );
  }
}