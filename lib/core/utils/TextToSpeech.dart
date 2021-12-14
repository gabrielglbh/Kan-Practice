import 'package:flutter_tts/flutter_tts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';

class TextToSpeech {
  /// Singleton instance of [TextToSpeech]
  static TextToSpeech instance = TextToSpeech();

  late FlutterTts _tts;

  TextToSpeech() {
    _tts = FlutterTts();
  }

  Future<void> speakKanji(Kanji? kanji) async {
    if (kanji != null) {
      await _tts.setLanguage("ja-JP");
      await _tts.setVolume(1.0);
      await _tts.speak(kanji.kanji);
    }
  }
}