part of 'list_details_words_bloc.dart';

@freezed
class ListDetailsWordsState with _$ListDetailsWordsState {
  const factory ListDetailsWordsState.initial() = ListDetailsWordsInitial;
  const factory ListDetailsWordsState.loaded(List<Word> list, String name) =
      ListDetailsWordsLoaded;
  const factory ListDetailsWordsState.practiceLoaded(
      StudyModes mode, List<Word> list) = ListDetailsWordsPracticeLoaded;
  const factory ListDetailsWordsState.loading() = ListDetailsWordsLoading;
  const factory ListDetailsWordsState.error(String message) =
      ListDetailsWordsError;
}
