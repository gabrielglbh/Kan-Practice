import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/tts.dart';

class TTSIconButton extends StatelessWidget {
  final String? kanji;
  final double iconSize;
  const TTSIconButton({
    Key? key,
    required this.kanji,
    this.iconSize = 24
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.volume_up_rounded),
      iconSize: iconSize,
      onPressed: () async {
       await TextToSpeech.instance.speakKanji(kanji);
      },
    );
  }
}
