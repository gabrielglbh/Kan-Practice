part of 'list_details_grammar_points_bloc.dart';

@freezed
class ListDetailsGrammarPointsState with _$ListDetailsGrammarPointsState {
  const factory ListDetailsGrammarPointsState.initial() =
      ListDetailsGrammarPointsInitial;
  const factory ListDetailsGrammarPointsState.loaded(
      List<GrammarPoint> list, String name) = ListDetailsGrammarPointsLoaded;
  const factory ListDetailsGrammarPointsState.practiceLoaded(
          GrammarModes mode, List<GrammarPoint> list) =
      ListDetailsGrammarPointsPracticeLoaded;
  const factory ListDetailsGrammarPointsState.loading() =
      ListDetailsGrammarPointsLoading;
  const factory ListDetailsGrammarPointsState.error(String message) =
      ListDetailsGrammarPointsError;
}
