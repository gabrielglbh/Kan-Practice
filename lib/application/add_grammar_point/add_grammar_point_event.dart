part of 'add_grammar_point_bloc.dart';

abstract class AddGrammarPointEvent extends Equatable {
  const AddGrammarPointEvent();

  @override
  List<Object> get props => [];
}

class AddGrammarPointEventCreate extends AddGrammarPointEvent {
  final GrammarPoint grammarPoint;
  final bool exitMode;

  const AddGrammarPointEventCreate(
      {required this.grammarPoint, required this.exitMode});

  @override
  List<Object> get props => [grammarPoint, exitMode];
}

class AddGrammarPointEventUpdate extends AddGrammarPointEvent {
  final String listName;
  final String grammarPk;
  final Map<String, dynamic> parameters;

  const AddGrammarPointEventUpdate(this.listName, this.grammarPk,
      {required this.parameters});

  @override
  List<Object> get props => [listName, grammarPk, parameters];
}
