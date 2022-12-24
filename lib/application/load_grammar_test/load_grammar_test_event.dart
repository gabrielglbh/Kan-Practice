part of 'load_grammar_test_bloc.dart';

abstract class LoadGrammarTestEvent extends Equatable {
  const LoadGrammarTestEvent();

  @override
  List<Object> get props => [];
}

class LoadGrammarTestEventIdle extends LoadGrammarTestEvent {
  final Tests mode;

  const LoadGrammarTestEventIdle({required this.mode});

  @override
  List<Object> get props => [mode];
}

class LoadGrammarTestEventLoadList extends LoadGrammarTestEvent {
  final String? folder;
  final GrammarModes mode;
  final Tests type;
  final String? practiceList;

  const LoadGrammarTestEventLoadList({
    required this.folder,
    required this.mode,
    required this.type,
    this.practiceList,
  });

  @override
  List<Object> get props => [mode, type];
}
