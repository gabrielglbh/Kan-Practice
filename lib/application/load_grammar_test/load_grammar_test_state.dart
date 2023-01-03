part of 'load_grammar_test_bloc.dart';

abstract class LoadGrammarTestState extends Equatable {
  const LoadGrammarTestState();

  @override
  List<Object> get props => [];
}

class LoadGrammarTestStateIdle extends LoadGrammarTestState {
  final List<int> grammarToReview;

  const LoadGrammarTestStateIdle(this.grammarToReview);

  @override
  List<Object> get props => [grammarToReview];
}

class LoadGrammarTestStateLoadedList extends LoadGrammarTestState {
  final List<GrammarPoint> grammar;
  final GrammarModes mode;

  const LoadGrammarTestStateLoadedList(this.grammar, this.mode);

  @override
  List<Object> get props => [grammar, mode];
}
