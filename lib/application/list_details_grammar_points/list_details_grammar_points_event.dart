part of 'list_details_grammar_points_bloc.dart';

abstract class ListDetailGrammarPointsEvent extends Equatable {
  const ListDetailGrammarPointsEvent();

  @override
  List<Object> get props => [];
}

class ListDetailGrammarPointsEventLoading extends ListDetailGrammarPointsEvent {
  final String list;
  final bool reset;

  const ListDetailGrammarPointsEventLoading(this.list, {this.reset = false});

  @override
  List<Object> get props => [list, reset];
}

class ListDetailGrammarPointsEventSearching
    extends ListDetailGrammarPointsEvent {
  final String query;
  final String list;
  final bool reset;

  const ListDetailGrammarPointsEventSearching(this.query, this.list,
      {this.reset = false});

  @override
  List<Object> get props => [query, list, reset];
}

class ListDetailGrammarPointsEventLoadUpPractice
    extends ListDetailGrammarPointsEvent {
  final StudyModes studyMode;
  final String list;

  const ListDetailGrammarPointsEventLoadUpPractice(this.list, this.studyMode);

  @override
  List<Object> get props => [list, studyMode];
}
