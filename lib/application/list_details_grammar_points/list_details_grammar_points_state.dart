part of 'list_details_grammar_points_bloc.dart';

class ListDetailGrammarPointsState extends Equatable {
  const ListDetailGrammarPointsState();

  @override
  List<Object?> get props => [];
}

class ListDetailGrammarPointsStateIdle extends ListDetailGrammarPointsState {}

class ListDetailGrammarPointsStateLoading extends ListDetailGrammarPointsState {
}

class ListDetailGrammarPointsStateSearching
    extends ListDetailGrammarPointsState {}

class ListDetailGrammarPointsStateLoadedPractice
    extends ListDetailGrammarPointsState {
  final StudyModes mode;
  final List<GrammarPoint> list;

  const ListDetailGrammarPointsStateLoadedPractice(this.mode, this.list);

  @override
  List<Object> get props => [list, mode];
}

class ListDetailGrammarPointsStateLoaded extends ListDetailGrammarPointsState {
  final List<GrammarPoint> list;
  final String name;

  const ListDetailGrammarPointsStateLoaded(this.list, this.name);

  @override
  List<Object> get props => [list, name];
}

class ListDetailGrammarPointsStateFailure extends ListDetailGrammarPointsState {
  final String error;

  const ListDetailGrammarPointsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
