import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';

class KanjiBottomSheet extends StatelessWidget {
  /// Kanji object to be displayed
  final String listName;
  final Kanji? kanji;
  final Function() onRemove;
  final Function() onTap;
  const KanjiBottomSheet({required this.listName, required this.kanji,
    required this.onTap, required this.onRemove
  });

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected kanji
  static Future<String?> callKanjiModeBottomSheet(BuildContext context,
      String listName, Kanji? kanji, {required Function()
      onRemove, required Function() onTap}) async {
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

  _createDialogForDeletingKanji(BuildContext context, String? k) {
    if (k != null) {
      showDialog(
        context: context,
        builder: (context) => CustomDialog(
          title: Text("Remove a Kanji"),
          content: Text("Are you sure you want to remove this kanji?"),
          positiveButtonText: "Remove",
          onPositive: () async {
            final int code = await KanjiQueries.instance.removeKanji(listName, k);
            if (code == 0) {
              Navigator.of(context).pop();
              onRemove();
            }
            else if (code == 1) GeneralUtils.getSnackBar(context, "Error removing kanji");
            else GeneralUtils.getSnackBar(context, "Generic error removing kanji");
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
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _dragContainer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(kanji?.pronunciation ?? "?", textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(kanji?.kanji ?? "?", textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text((kanji?.meaning ?? "?"), textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: ListTile(
                      title: WinRateBarChart(dataSource: [
                        BarData(x: StudyModes.writing.mode, y: (kanji?.winRateWriting ?? -1), color: StudyModes.writing.color),
                        BarData(x: StudyModes.reading.mode, y: (kanji?.winRateReading ?? -1), color: StudyModes.reading.color),
                        BarData(x: StudyModes.recognition.mode, y: (kanji?.winRateRecognition ?? -1), color: StudyModes.recognition.color),
                      ])
                    ),
                  ),
                  Divider(),
                  _actionButtons(context),
                ],
              ),
            ),
          ]
        );
      },
    );
  }

  Container _actionButtons(BuildContext context) {
    return Container(
      height: actionButtonsKanjiDetail,
      child: Column(
        children: [
          ListTile(
            title: Text("Remove"),
            trailing: Icon(Icons.clear),
            onTap: () => _createDialogForDeletingKanji(context, kanji?.kanji),
          ),
          Divider(),
          ListTile(
            title: Text("Update"),
            trailing: Icon(Icons.arrow_forward_rounded),
            onTap: () {
              Navigator.of(context).pop();
              onTap();
            },
          )
        ],
      ),
    );
  }

  Align _dragContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 90, height: 5,
        margin: EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.grey
        ),
      ),
    );
  }
}