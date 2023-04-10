part of 'add_grammar_point_bloc.dart';

@freezed
class AddGrammarPointState with _$AddGrammarPointState {
  const factory AddGrammarPointState.loading() = AddGrammarPointLoading;
  const factory AddGrammarPointState.updateDone() = AddGrammarPointUpdateDone;
  const factory AddGrammarPointState.initial() = AddGrammarPointInitial;
  const factory AddGrammarPointState.creationDone(bool exitMode) =
      AddGrammarPointCreationDone;
  const factory AddGrammarPointState.error(String message) =
      AddGrammarPointError;
}
