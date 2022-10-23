import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/text_to_speech/i_text_to_speech_repository.dart';

@injectable
class TextToSpeechService {
  final ITextToSpeechRepository _textToSpeechRepository;

  TextToSpeechService(this._textToSpeechRepository);

  Future<void> speakWord(String? word) async {
    await _textToSpeechRepository.speakWord(word);
  }
}
