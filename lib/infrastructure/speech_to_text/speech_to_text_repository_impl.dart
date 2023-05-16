import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/speech_to_text/i_speech_to_text_repository.dart';
import 'package:speech_to_text/speech_to_text.dart';

@LazySingleton(as: ISpeechToTextRepository)
class SpeechToTextRepositoryImpl implements ISpeechToTextRepository {
  final SpeechToText _stt;

  SpeechToTextRepositoryImpl(this._stt);

  @override
  Future<bool> initialize() async {
    return await _stt.initialize();
  }

  @override
  SpeechToText recognize() => _stt;
}
