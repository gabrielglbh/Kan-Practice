import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';

class KanjiItem extends StatelessWidget {
  final String listName;
  final Kanji kanji;
  final StudyModes selectedMode;
  final Function onRemoval;
  final Function onTap;
  const KanjiItem({required this.listName, required this.kanji,
    required this.onRemoval, required this.onTap, required this.selectedMode});

  double _getProperKanjiWinRate(Kanji kanji) {
    switch (selectedMode) {
      case StudyModes.writing:
        return kanji.winRateWriting;
      case StudyModes.reading:
        return kanji.winRateReading;
      case StudyModes.recognition:
        return kanji.winRateRecognition;
    }
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
            if (code == 0) onRemoval();
            else if (code == 1) GeneralUtils.getSnackBar(context, "Error removing kanji");
            else GeneralUtils.getSnackBar(context, "Generic error removing kanji");
          }
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await onTap(),
      onLongPress: () => _createDialogForDeletingKanji(context, kanji.kanji),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: GeneralUtils.getColorBasedOnWinRate(_getProperKanjiWinRate(kanji)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: 4)
          ]
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(kanji.kanji, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black)),
        )
      ),
    );
  }
}
