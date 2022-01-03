import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/TextToSpeech.dart';

class TTSIconButton extends StatelessWidget {
  final String? kanji;
  final double iconSize;
  const TTSIconButton({required this.kanji, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.volume_up_rounded),
      iconSize: iconSize,
      onPressed: () async {
       await TextToSpeech.instance.speakKanji(kanji);
      },
    );
  }
}
