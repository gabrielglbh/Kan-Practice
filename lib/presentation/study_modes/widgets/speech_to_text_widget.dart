import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_validation_buttons.dart';
import 'package:kanpractice/presentation/study_modes/widgets/wave.dart';

class SpeechToTextWidget extends StatelessWidget {
  final String predictedWords;
  final bool isListening;
  final bool isValidating;
  final double score;
  final Function() onTapWhenListen;
  final Function() onSubmit;
  const SpeechToTextWidget({
    super.key,
    required this.predictedWords,
    required this.isListening,
    required this.onTapWhenListen,
    required this.onSubmit,
    required this.isValidating,
    this.score = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    if (predictedWords.isEmpty) {
      if (isListening) {
        return Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: KPMargins.margin64 * 2,
            color: KPColors.getPrimary(context),
            margin: const EdgeInsets.symmetric(horizontal: KPMargins.margin24),
            child: MusicVisualizer(
              colors: const [
                KPColors.secondaryColor,
                KPColors.secondaryDarkerColor
              ],
              duration: const [300, 1000, 500, 200, 400],
              barCount: 24,
            ),
          ),
        );
      }
      return Expanded(
        child: GestureDetector(
          onTap: () async {
            await onTapWhenListen();
          },
          child: Container(
            width: KPMargins.margin64 * 2,
            height: KPMargins.margin64 * 2,
            decoration: BoxDecoration(
              color: KPColors.getSecondaryColor(context),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic_rounded,
              color: Colors.white,
              size: KPMargins.margin64,
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.record_voice_over_rounded),
              const SizedBox(width: KPMargins.margin12),
              Flexible(
                child: Text(
                  predictedWords,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
          if (isValidating)
            Container(
              width: KPMargins.margin64 * 2,
              height: KPMargins.margin64 * 2,
              decoration: BoxDecoration(
                color: Utils.getColorBasedOnWinRate(score),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(KPMargins.margin12),
              child: Icon(
                Utils.getEmojiBasedOnWinRate(score),
                color: Colors.white,
                size: KPMargins.margin64,
              ),
            ),
          if (!isValidating)
            KPValidationButtons(
              trigger: false,
              submitLabel: "done_button_label".tr(),
              action: (_) {},
              onSubmit: () async {
                await onSubmit();
              },
            ),
          if (!isValidating)
            IconButton(
              onPressed: () async {
                await onTapWhenListen();
              },
              icon: const Icon(Icons.repeat),
            ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
