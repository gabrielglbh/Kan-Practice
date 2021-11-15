import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/widgets/KanjiBottomSheet.dart';

class KanjiItem extends StatelessWidget {
  final String listName;
  final KanjiList list;
  final Kanji kanji;
  final StudyModes selectedMode;
  final Function() onRemoval;
  final Function() onTap;
  const KanjiItem({required this.listName, required this.kanji, required this.list,
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          onTap: () async {
            await KanjiBottomSheet.callKanjiModeBottomSheet(context,
                listName, kanji, onTap: onTap, onRemove: onRemoval);
          },
          // _createDialogForDeletingKanji(context, kanji.kanji),,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(kanji.kanji, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            )
          ),
        ),
      )
    );
  }
}
