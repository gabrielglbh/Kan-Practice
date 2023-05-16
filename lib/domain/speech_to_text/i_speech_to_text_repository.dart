import 'package:speech_to_text/speech_to_text.dart';

abstract class ISpeechToTextRepository {
  Future<bool> initialize();
  SpeechToText recognize();
}
