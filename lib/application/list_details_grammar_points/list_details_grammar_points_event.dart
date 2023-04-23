part of 'list_details_grammar_points_bloc.dart';

abstract class ListDetailsGrammarPointsEvent extends Equatable {
  const ListDetailsGrammarPointsEvent();

  @override
  List<Object> get props => [];
}

class ListDetailsGrammarPointsEventLoading
    extends ListDetailsGrammarPointsEvent {
  final String list;
  final bool reset;

  const ListDetailsGrammarPointsEventLoading(this.list, {this.reset = false});

  @override
  List<Object> get props => [list, reset];
}

class ListDetailsGrammarPointsEventSearching
    extends ListDetailsGrammarPointsEvent {
  final String query;
  final String list;
  final bool reset;

  const ListDetailsGrammarPointsEventSearching(this.query, this.list,
      {this.reset = false});

  @override
  List<Object> get props => [query, list, reset];
}

class ListDetailsGrammarPointsEventLoadUpPractice
    extends ListDetailsGrammarPointsEvent {
  final GrammarModes grammarMode;
  final String list;

  const ListDetailsGrammarPointsEventLoadUpPractice(
      this.list, this.grammarMode);

  @override
  List<Object> get props => [list, grammarMode];
}
