import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/kp_kanji_bottom_sheet.dart';
import 'package:kanpractice/ui/consts.dart';

class KanjiItem extends StatelessWidget {
  final bool aggregateStats;
  final String listName;
  final KanjiList list;
  final Kanji kanji;
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

  double _getProperKanjiWinRate(Kanji kanji) {
    if (aggregateStats) {
      return ((kanji.winRateWriting == DatabaseConstants.emptyWinRate
                  ? 0
                  : kanji.winRateWriting) +
              (kanji.winRateReading == DatabaseConstants.emptyWinRate
                  ? 0
                  : kanji.winRateReading) +
              (kanji.winRateRecognition == DatabaseConstants.emptyWinRate
                  ? 0
                  : kanji.winRateRecognition) +
              (kanji.winRateListening == DatabaseConstants.emptyWinRate
                  ? 0
                  : kanji.winRateListening) +
              (kanji.winRateSpeaking == DatabaseConstants.emptyWinRate
                  ? 0
                  : kanji.winRateSpeaking)) /
          StudyModes.values.length;
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
      duration: const Duration(milliseconds: CustomAnimations.ms300),
      padding: const EdgeInsets.all(Margins.margin2),
      margin: const EdgeInsets.all(Margins.margin4),
      decoration: BoxDecoration(
          color: GeneralUtils.getColorBasedOnWinRate(
              _getProperKanjiWinRate(kanji)),
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
            onShowModal();
            await KPKanjiBottomSheet.show(context, listName, kanji,
                onTap: onTap, onRemove: onRemoval);
          },
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(CustomRadius.radius8))),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(kanji.kanji,
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
