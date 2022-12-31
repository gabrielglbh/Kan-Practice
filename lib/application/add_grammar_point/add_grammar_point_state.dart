part of 'add_grammar_point_bloc.dart';

class AddGrammarPointState extends Equatable {
  const AddGrammarPointState();

  @override
  List<Object?> get props => [];
}

class AddGrammarPointStateIdle extends AddGrammarPointState {}

class AddGrammarPointStateLoading extends AddGrammarPointState {}

class AddGrammarPointStateDoneCreating extends AddGrammarPointState {
  final bool exitMode;

  const AddGrammarPointStateDoneCreating({required this.exitMode});

  @override
  List<Object?> get props => [exitMode];
}

class AddGrammarPointStateDoneUpdating extends AddGrammarPointState {}

class AddGrammarPointStateFailure extends AddGrammarPointState {
  final String message;

  const AddGrammarPointStateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
