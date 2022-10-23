import 'package:flutter/material.dart';
import 'package:kanpractice/infrastructure/text_to_speech/text_to_speech_repository_impl.dart';
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
        await getIt<TextToSpeechRepositoryImpl>().speakWord(word);
      },
    );
  }
}
