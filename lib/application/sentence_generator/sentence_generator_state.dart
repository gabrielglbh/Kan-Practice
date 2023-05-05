part of 'sentence_generator_bloc.dart';

@freezed
class SentenceGeneratorState with _$SentenceGeneratorState {
  const factory SentenceGeneratorState.initial() = SentenceGeneratorInitial;
  const factory SentenceGeneratorState.loading() = SentenceGeneratorLoading;
  const factory SentenceGeneratorState.succeeded(
      String sentence, List<String> words) = SentenceGeneratorSucceeded;
  const factory SentenceGeneratorState.error() = SentenceGeneratorError;
}
