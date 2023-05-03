import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tts_icon_button.dart';

class ContextWidget extends StatelessWidget {
  final String word;
  final String sentence;
  final bool showWord;
  const ContextWidget({
    super.key,
    required this.word,
    required this.showWord,
    required this.sentence,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyLarge;
    late Widget child;

    if (!showWord) {
      child = Text(
          '${'provide_context'.tr()}: ${sentence.replaceAll(word, '「 ____ 」')}',
          textAlign: TextAlign.center,
          style: theme);
    } else {
      final parts = sentence.splitMapJoin(word);
      child = RichText(
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
      padding: const EdgeInsets.only(
        top: KPMargins.margin12,
        left: KPMargins.margin16,
        right: KPMargins.margin16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(child: child),
          const SizedBox(width: KPMargins.margin8),
          TTSIconButton(word: sentence),
        ],
      ),
    );
  }
}
