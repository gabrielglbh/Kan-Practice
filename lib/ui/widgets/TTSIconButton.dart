import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/TextToSpeech.dart';

class TTSIconButton extends StatelessWidget {
  final String? kanji;
  final bool hidden;
  const TTSIconButton({required this.kanji, this.hidden = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.volume_up_rounded),
      color: hidden ? Theme.of(context).brightness == Brightness.light
          ? Colors.white : Colors.grey[700]! : null,
      splashColor: hidden ? Theme.of(context).brightness == Brightness.light
          ? Colors.white : Colors.grey[700]! : null,
      onPressed: () async {
        if (!hidden) await TextToSpeech.instance.speakKanji(kanji);
      },
    );
  }
}
