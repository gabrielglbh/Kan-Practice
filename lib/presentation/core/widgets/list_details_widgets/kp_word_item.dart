import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/widgets/kp_word_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class KPWordItem extends StatelessWidget {
  final bool aggregateStats;
  final String? listName;
  final Word word;
  final StudyModes selectedMode;
  final Function()? onRemoval;
  final Function()? onTap;
  final int index;
  final Function() onShowModal;
  final bool isBadge;
  const KPWordItem({
    Key? key,
    this.aggregateStats = false,
    this.listName,
    required this.word,
    this.onRemoval,
    this.onTap,
    required this.selectedMode,
    required this.index,
    required this.onShowModal,
    this.isBadge = true,
  }) : super(key: key);

  double _getProperWordWinRate(Word word) {
    if (aggregateStats) {
      final writing = (word.winRateWriting == DatabaseConstants.emptyWinRate
          ? 0
          : word.winRateWriting);
      final reading = (word.winRateReading == DatabaseConstants.emptyWinRate
          ? 0
          : word.winRateReading);
      final recognition =
          (word.winRateRecognition == DatabaseConstants.emptyWinRate
              ? 0
              : word.winRateRecognition);
      final listening = (word.winRateListening == DatabaseConstants.emptyWinRate
          ? 0
          : word.winRateListening);
      final speaking = (word.winRateSpeaking == DatabaseConstants.emptyWinRate
          ? 0
          : word.winRateSpeaking);

      final aggregate = writing + reading + recognition + listening + speaking;
      if (aggregate == 0) return -1;
      return aggregate / StudyModes.values.length;
    }

    switch (selectedMode) {
      case StudyModes.writing:
        return word.winRateWriting;
      case StudyModes.reading:
        return word.winRateReading;
      case StudyModes.recognition:
        return word.winRateRecognition;
      case StudyModes.listening:
        return word.winRateListening;
      case StudyModes.speaking:
      default:
        return word.winRateSpeaking;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badge = AnimatedContainer(
      duration: const Duration(milliseconds: KPAnimations.ms300),
      padding: const EdgeInsets.all(KPMargins.margin2),
      margin: const EdgeInsets.all(KPMargins.margin4),
      decoration: BoxDecoration(
          color: Utils.getColorBasedOnWinRate(_getProperWordWinRate(word)),
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
            await KPWordBottomSheet.show(context, listName, word,
                onTap: onTap, onRemove: onRemoval);
          },
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(KPRadius.radius8))),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(word.word,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: KPColors.accentLight)),
              )),
        ),
      ),
    );

    final tile = ListTile(
      leading: Container(
        width: KPMargins.margin16,
        height: KPMargins.margin16,
        margin: const EdgeInsets.only(top: KPMargins.margin4),
        decoration: BoxDecoration(
          color: Utils.getColorBasedOnWinRate(_getProperWordWinRate(word)),
          shape: BoxShape.circle,
          border: Border.all(color: KPColors.getSubtle(context)),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: KPMargins.margin4),
              child: Text(word.word,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: KPMargins.margin16),
          Text(word.meaning,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
      onTap: () async {
        onShowModal();
        await KPWordBottomSheet.show(context, listName, word,
            onTap: onTap, onRemove: onRemoval);
      },
    );

    return isBadge ? badge : tile;
  }
}
