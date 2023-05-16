part of 'speech_to_text_bloc.dart';

@freezed
class SpeechToTextState with _$SpeechToTextState {
  const factory SpeechToTextState.listening() = SpeechToTextListening;
  const factory SpeechToTextState.initial() = SpeechToTextInitial;
  const factory SpeechToTextState.available() = SpeechToTextAvailable;
  const factory SpeechToTextState.error() = SpeechToTextError;
  const factory SpeechToTextState.providedWords(List<String> recognizedWords) =
      SpeechToTextProvidedWords;
}
