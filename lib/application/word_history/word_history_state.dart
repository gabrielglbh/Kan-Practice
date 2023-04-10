part of 'word_history_bloc.dart';

@freezed
class WordHistoryState with _$WordHistoryState {
  const factory WordHistoryState.initial() = WordHistoryInitial;
  const factory WordHistoryState.loading() = WordHistoryLoading;
  const factory WordHistoryState.error() = WordHistoryError;
  const factory WordHistoryState.loaded(List<WordHistory> list) =
      WordHistoryLoaded;
}
