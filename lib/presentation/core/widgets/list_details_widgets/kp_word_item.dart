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
    super.key,
    this.aggregateStats = false,
    this.listName,
    required this.word,
    this.onRemoval,
    this.onTap,
    required this.selectedMode,
    required this.index,
    required this.onShowModal,
    this.isBadge = true,
  });

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
    final score = _getProperWordWinRate(word);
    return ListTile(
      horizontalTitleGap: 0,
      leading: score == -1
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: KPMargins.margin16,
                  height: KPMargins.margin16,
                  margin: const EdgeInsets.only(top: KPMargins.margin4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: KPMargins.margin16 - 3,
                  height: KPMargins.margin16 - 3,
                  margin: const EdgeInsets.only(top: KPMargins.margin4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: KPMargins.margin4,
                  height: KPMargins.margin4,
                  margin: const EdgeInsets.only(top: KPMargins.margin4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            )
          : Container(
              width: KPMargins.margin16,
              height: KPMargins.margin16,
              margin: const EdgeInsets.only(top: KPMargins.margin4),
              decoration: BoxDecoration(
                color: score.getColorBasedOnWinRate(context),
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child:
                Text(word.word, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(width: KPMargins.margin8),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2.5),
            child: Text(word.meaning,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyMedium),
          )
        ],
      ),
      onTap: () async {
        onShowModal();
        await KPWordBottomSheet.show(context, listName, word,
            onTap: onTap, onRemove: onRemoval);
      },
    );
  }
}
