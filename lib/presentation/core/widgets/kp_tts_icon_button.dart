import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/text_to_speech_service.dart';
import 'package:kanpractice/injection.dart';

class TTSIconButton extends StatelessWidget {
  final String? word;
  final double iconSize;
  const TTSIconButton({Key? key, required this.word, this.iconSize = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.volume_up_rounded),
      iconSize: iconSize,
      onPressed: () async {
        await getIt<TextToSpeechService>().speakWord(word);
      },
    );
  }
}
