part of 'archive_words_bloc.dart';

class ArchiveWordsState extends Equatable {
  const ArchiveWordsState();

  @override
  List<Object?> get props => [];
}

class ArchiveWordsStateIdle extends ArchiveWordsState {}

class ArchiveWordsStateLoading extends ArchiveWordsState {}

class ArchiveWordsStateSearching extends ArchiveWordsState {}

class ArchiveWordsStateLoaded extends ArchiveWordsState {
  final List<Word> list;

  const ArchiveWordsStateLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class ArchiveWordsStateFailure extends ArchiveWordsState {
  final String error;

  const ArchiveWordsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
