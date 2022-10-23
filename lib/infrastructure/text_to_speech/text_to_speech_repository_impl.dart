import 'package:flutter_tts/flutter_tts.dart';
import 'package:kanpractice/domain/text_to_speech/i_text_to_speech_repository.dart';

class TextToSpeechRepositoryImpl implements ITextToSpeechRepository {
  final FlutterTts _tts;

  TextToSpeechRepositoryImpl(this._tts);

  @override
  Future<void> speakWord(String? word) async {
    if (word != null) {
      await _tts.setLanguage("ja-JP");
      await _tts.setVolume(1.0);
      await _tts.speak(word);
    }
  }
}
