import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/widgets/KanjiBottomSheet.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class KanjiItem extends StatefulWidget {
  final String listName;
  final KanjiList list;
  final Kanji kanji;
  final StudyModes selectedMode;
  final Function() onRemoval;
  final Function() onTap;
  final int index;
  const KanjiItem({required this.listName, required this.kanji, required this.list,
    required this.onRemoval, required this.onTap, required this.selectedMode, required this.index});

  @override
  _KanjiItemState createState() => _KanjiItemState();
}

class _KanjiItemState extends State<KanjiItem> {
  double _itemOpacity = 0.4;

  double _getProperKanjiWinRate(Kanji kanji) {
    switch (widget.selectedMode) {
      case StudyModes.writing:
        return kanji.winRateWriting;
      case StudyModes.reading:
        return kanji.winRateReading;
      case StudyModes.recognition:
        return kanji.winRateRecognition;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() => _itemOpacity = 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, 0.4), end: Offset(0, 0)),
      duration: Duration(milliseconds: CustomAnimations.kanjiItemDuration * widget.index),
      curve: Curves.linear,
      builder: (context, offset, child) {
        return FractionalTranslation(translation: offset as Offset, child: child);
      },
      child: AnimatedOpacity(
        opacity: _itemOpacity,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: CustomAnimations.kanjiItemDuration * widget.index),
        child: _item(context),
      ),
    );
  }

  AnimatedContainer _item(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: CustomAnimations.ms300),
      padding: EdgeInsets.all(Margins.margin2),
      margin: EdgeInsets.all(Margins.margin4),
      decoration: BoxDecoration(
        color: GeneralUtils.getColorBasedOnWinRate(_getProperKanjiWinRate(widget.kanji)),
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius8)),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: CustomRadius.radius4)
        ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius8)),
          onTap: () async {
            await KanjiBottomSheet.callKanjiModeBottomSheet(context,
                widget.listName, widget.kanji, onTap: widget.onTap, onRemove: widget.onRemoval);
          },
          // _createDialogForDeletingKanji(context, kanji.kanji),,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius8))),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(widget.kanji.kanji, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSizes.fontSize20, color: Colors.black)),
            )
          ),
        ),
      )
    );
  }
}
