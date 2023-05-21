import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tts_icon_button.dart';

class ContextWidget extends StatelessWidget {
  final String word;
  final String sentence;
  final StudyModes mode;
  final bool showWord;
  final bool hasTTS;
  const ContextWidget({
    super.key,
    required this.word,
    required this.showWord,
    required this.sentence,
    required this.mode,
    this.hasTTS = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyLarge;
    late Widget child;

    if (!showWord) {
      final splitted = sentence.replaceAll(
        word,
        mode == StudyModes.reading || mode == StudyModes.recognition
            ? '「 $word 」'
            : '「 ____ 」',
      );
      child = Text(splitted, textAlign: TextAlign.center, style: theme);
    } else {
      final parts = sentence.splitMapJoin(word);
      child = sentence == word
          ? Text(sentence, style: theme)
          : RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: List.generate(parts.length, (i) {
                  return TextSpan(
                    text: parts[i] == word ? '「 ${parts[i]} 」' : parts[i],
                    style: theme,
                  );
                }),
              ),
            );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: KPMargins.margin12,
        left: hasTTS ? KPMargins.margin4 : KPMargins.margin16,
        right: hasTTS ? KPMargins.margin4 : KPMargins.margin16,
      ),
      child: hasTTS
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: KPMargins.margin48),
                Expanded(child: child),
                TTSIconButton(word: sentence),
              ],
            )
          : child,
    );
  }
}
