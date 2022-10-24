import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanji_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class KanjiItem extends StatelessWidget {
  final bool aggregateStats;
  final String listName;
  final WordList list;
  final Word kanji;
  final StudyModes selectedMode;
  final Function() onRemoval;
  final Function() onTap;
  final int index;
  final Function() onShowModal;
  const KanjiItem({
    Key? key,
    this.aggregateStats = false,
    required this.listName,
    required this.kanji,
    required this.list,
    required this.onRemoval,
    required this.onTap,
    required this.selectedMode,
    required this.index,
    required this.onShowModal,
  }) : super(key: key);

  double _getProperKanjiWinRate(Word kanji) {
    if (aggregateStats) {
      final writing = (kanji.winRateWriting == DatabaseConstants.emptyWinRate
          ? 0
          : kanji.winRateWriting);
      final reading = (kanji.winRateReading == DatabaseConstants.emptyWinRate
          ? 0
          : kanji.winRateReading);
      final recognition =
          (kanji.winRateRecognition == DatabaseConstants.emptyWinRate
              ? 0
              : kanji.winRateRecognition);
      final listening =
          (kanji.winRateListening == DatabaseConstants.emptyWinRate
              ? 0
              : kanji.winRateListening);
      final speaking = (kanji.winRateSpeaking == DatabaseConstants.emptyWinRate
          ? 0
          : kanji.winRateSpeaking);

      final aggregate = writing + reading + recognition + listening + speaking;
      if (aggregate == 0) return -1;
      return aggregate / StudyModes.values.length;
    }

    switch (selectedMode) {
      case StudyModes.writing:
        return kanji.winRateWriting;
      case StudyModes.reading:
        return kanji.winRateReading;
      case StudyModes.recognition:
        return kanji.winRateRecognition;
      case StudyModes.listening:
        return kanji.winRateListening;
      case StudyModes.speaking:
      default:
        return kanji.winRateSpeaking;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: KPAnimations.ms300),
      padding: const EdgeInsets.all(KPMargins.margin2),
      margin: const EdgeInsets.all(KPMargins.margin4),
      decoration: BoxDecoration(
          color: Utils.getColorBasedOnWinRate(_getProperKanjiWinRate(kanji)),
          borderRadius:
              const BorderRadius.all(Radius.circular(KPRadius.radius8)),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                blurRadius: KPRadius.radius4)
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              const BorderRadius.all(Radius.circular(KPRadius.radius8)),
          onTap: () async {
            onShowModal();
            await KPKanjiBottomSheet.show(context, listName, kanji,
                onTap: onTap, onRemove: onRemoval);
          },
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(KPRadius.radius8))),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(kanji.word,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.black)),
              )),
        ),
      ),
    );
  }
}
