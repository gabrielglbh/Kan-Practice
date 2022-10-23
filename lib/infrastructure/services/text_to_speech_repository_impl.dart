import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_text_to_speech_repository.dart';

@LazySingleton(as: ITextToSpeechRepository)
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
