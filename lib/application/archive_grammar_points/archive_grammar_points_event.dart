part of 'archive_grammar_points_bloc.dart';

abstract class ArchiveGrammarPointsEvent extends Equatable {
  const ArchiveGrammarPointsEvent();

  @override
  List<Object> get props => [];
}

class ArchiveGrammarPointsEventLoading extends ArchiveGrammarPointsEvent {
  final bool reset;

  const ArchiveGrammarPointsEventLoading({this.reset = false});

  @override
  List<Object> get props => [reset];
}

class ArchiveGrammarPointsEventSearching extends ArchiveGrammarPointsEvent {
  final String query;
  final bool reset;

  const ArchiveGrammarPointsEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}
