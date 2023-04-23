part of 'grammar_test_bloc.dart';

abstract class GrammarTestEvent extends Equatable {
  const GrammarTestEvent();

  @override
  List<Object> get props => [];
}

class GrammarTestEventIdle extends GrammarTestEvent {
  final Tests mode;

  const GrammarTestEventIdle({required this.mode});

  @override
  List<Object> get props => [mode];
}

class GrammarTestEventLoadList extends GrammarTestEvent {
  final String? folder;
  final GrammarModes mode;
  final Tests type;
  final String? practiceList;
  final List<String>? selectionQuery;

  const GrammarTestEventLoadList({
    required this.folder,
    required this.mode,
    required this.type,
    this.practiceList,
    this.selectionQuery,
  });

  @override
  List<Object> get props => [mode, type];
}
