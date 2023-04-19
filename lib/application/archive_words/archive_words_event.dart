part of 'archive_words_bloc.dart';

abstract class ArchiveWordsEvent extends Equatable {
  const ArchiveWordsEvent();

  @override
  List<Object> get props => [];
}

class ArchiveWordsEventLoading extends ArchiveWordsEvent {
  final bool reset;

  /// Maintains the filter applied by the user for loading new lists
  final WordCategoryFilter filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const ArchiveWordsEventLoading(
      {required this.filter, required this.order, this.reset = false});

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
