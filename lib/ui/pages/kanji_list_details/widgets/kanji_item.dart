import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/kp_kanji_bottom_sheet.dart';
import 'package:kanpractice/ui/consts.dart';

class KanjiItem extends StatefulWidget {
  final String listName;
  final KanjiList list;
  final Kanji kanji;
  final StudyModes selectedMode;
  final Function() onRemoval;
  final Function() onTap;
  final int index;
  final Function() onShowModal;
  const KanjiItem(
      {Key? key,
      required this.listName,
      required this.kanji,
      required this.list,
      required this.onRemoval,
      required this.onTap,
      required this.selectedMode,
      required this.index,
      required this.onShowModal})
      : super(key: key);

  @override
  _KanjiItemState createState() => _KanjiItemState();
}

class _KanjiItemState extends State<KanjiItem> {
  //double _itemOpacity = 0.4;

  double _getProperKanjiWinRate(Kanji kanji) {
    switch (widget.selectedMode) {
      case StudyModes.writing:
        return kanji.winRateWriting;
      case StudyModes.reading:
        return kanji.winRateReading;
      case StudyModes.recognition:
        return kanji.winRateRecognition;
      case StudyModes.listening:
        return kanji.winRateListening;
    }
  }

  @override
  void initState() {
    /*WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() => _itemOpacity = 1);
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _item(context);
    /*return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, 0.4), end: const Offset(0, 0)),
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
    );*/
  }

  AnimatedContainer _item(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: CustomAnimations.ms300),
        padding: const EdgeInsets.all(Margins.margin2),
        margin: const EdgeInsets.all(Margins.margin4),
        decoration: BoxDecoration(
            color: GeneralUtils.getColorBasedOnWinRate(
                _getProperKanjiWinRate(widget.kanji)),
            borderRadius:
                const BorderRadius.all(Radius.circular(CustomRadius.radius8)),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  blurRadius: CustomRadius.radius4)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius:
                const BorderRadius.all(Radius.circular(CustomRadius.radius8)),
            onTap: () async {
              widget.onShowModal();
              await KPKanjiBottomSheet.show(
                  context, widget.listName, widget.kanji,
                  onTap: widget.onTap, onRemove: widget.onRemoval);
            },
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(CustomRadius.radius8))),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(widget.kanji.kanji,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: Colors.black)),
                )),
          ),
        ));
  }
}
