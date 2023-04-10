part of 'archive_words_bloc.dart';

@freezed
class ArchiveWordsState with _$ArchiveWordsState {
  const factory ArchiveWordsState.loading() = ArchiveWordsLoading;
  const factory ArchiveWordsState.loaded(List<Word> list) = ArchiveWordsLoaded;
  const factory ArchiveWordsState.initial() = ArchiveWordsInitial;
  const factory ArchiveWordsState.error() = ArchiveWordsError;
}
