part of 'archive_words_bloc.dart';

abstract class ArchiveWordsEvent extends Equatable {
  const ArchiveWordsEvent();

  @override
  List<Object> get props => [];
}

class ArchiveWordsEventLoading extends ArchiveWordsEvent {
  final bool reset;

  const ArchiveWordsEventLoading({this.reset = false});

  @override
  List<Object> get props => [reset];
}

class ArchiveWordsEventSearching extends ArchiveWordsEvent {
  final String query;
  final bool reset;

  const ArchiveWordsEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}
