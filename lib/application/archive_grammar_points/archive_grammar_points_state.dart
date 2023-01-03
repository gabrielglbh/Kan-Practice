part of 'archive_grammar_points_bloc.dart';

class ArchiveGrammarPointsState extends Equatable {
  const ArchiveGrammarPointsState();

  @override
  List<Object?> get props => [];
}

class ArchiveGrammarPointsStateIdle extends ArchiveGrammarPointsState {}

class ArchiveGrammarPointsStateLoading extends ArchiveGrammarPointsState {}

class ArchiveGrammarPointsStateSearching extends ArchiveGrammarPointsState {}

class ArchiveGrammarPointsStateLoaded extends ArchiveGrammarPointsState {
  final List<GrammarPoint> list;

  const ArchiveGrammarPointsStateLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class ArchiveGrammarPointsStateFailure extends ArchiveGrammarPointsState {
  final String error;

  const ArchiveGrammarPointsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
