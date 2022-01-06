import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/KanListTile.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/RadialGraph.dart';
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
  static Future<String?> show(BuildContext context,
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
                  KanListTableFields.totalWinRateRecognitionField: DatabaseConstants.emptyWinRate,
                  KanListTableFields.totalWinRateListeningField: DatabaseConstants.emptyWinRate
                });
              } else {
                double wNewScore = kanList.totalWinRateWriting;
                double readNewScore = kanList.totalWinRateReading;
                double recNewScore = kanList.totalWinRateRecognition;
                double lisNewScore = kanList.totalWinRateListening;

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
                if (k.winRateListening != DatabaseConstants.emptyWinRate) {
                  double y = (list.length + 1) * kanList.totalWinRateListening;
                  double partialScore = y - k.winRateListening;
                  lisNewScore = partialScore / list.length;
                }

                await ListQueries.instance.updateList(listName, {
                  KanListTableFields.totalWinRateWritingField: wNewScore,
                  KanListTableFields.totalWinRateReadingField: readNewScore,
                  KanListTableFields.totalWinRateRecognitionField: recNewScore,
                  KanListTableFields.totalWinRateListeningField: lisNewScore
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
                            Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                                arguments: JishoArguments(kanji: kanji?.kanji));
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
                        TTSIconButton(kanji: kanji?.pronunciation)
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
                      title: StorageManager.readData(StorageManager.kanListGraphVisualization) == VisualizationMode.barChart.name
                          ? _barChart() : RadialGraph(
                        rateWriting: kanji?.winRateWriting ?? DatabaseConstants.emptyWinRate,
                        rateReading: kanji?.winRateReading ?? DatabaseConstants.emptyWinRate,
                        rateRecognition: kanji?.winRateRecognition ?? DatabaseConstants.emptyWinRate,
                        rateListening: kanji?.winRateListening ?? DatabaseConstants.emptyWinRate,
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Margins.margin8, right: Margins.margin8, bottom: Margins.margin16
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text("${"created_label".tr()} "
                          "${GeneralUtils.parseDateMilliseconds(context, (kanji?.dateAdded ?? 0))} • "
                          "${"last_seen_label".tr()} "
                          "${GeneralUtils.parseDateMilliseconds(context, (kanji?.dateLastShown ?? 0))}",
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

  Widget _barChart() {
    return WinRateBarChart(dataSource: List.generate(StudyModes.values.length, (index) {
      switch (StudyModes.values[index]) {
        case StudyModes.writing:
          return BarData(x: StudyModes.writing.mode,
              y: (kanji?.winRateWriting ?? DatabaseConstants.emptyWinRate),
              color: StudyModes.writing.color);
        case StudyModes.reading:
          return BarData(x: StudyModes.reading.mode,
              y: (kanji?.winRateReading ?? DatabaseConstants.emptyWinRate),
              color: StudyModes.reading.color);
        case StudyModes.recognition:
          return BarData(x: StudyModes.recognition.mode,
              y: (kanji?.winRateRecognition ?? DatabaseConstants.emptyWinRate),
              color: StudyModes.recognition.color);
        case StudyModes.listening:
          return BarData(x: StudyModes.listening.mode,
              y: (kanji?.winRateListening ?? DatabaseConstants.emptyWinRate),
              color: StudyModes.listening.color);
      }
    }));
  }

  Container _actionButtons(BuildContext context) {
    return Container(
      height: CustomSizes.actionButtonsKanjiDetail,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text("kanji_bottom_sheet_removal_label".tr()),
              trailing: Icon(Icons.clear),
              onTap: () {
                Navigator.of(context).pop();
                _createDialogForDeletingKanji(context, kanji);
              },
            ),
          ),
          RotatedBox(quarterTurns: 1, child: Divider()),
          Expanded(
            child: ListTile(
              title: Text("kanji_bottom_sheet_update_label".tr()),
              trailing: Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.of(context).pop();
                if (onTap != null) onTap!();
              },
            ),
          )
        ],
      ),
    );
  }
}