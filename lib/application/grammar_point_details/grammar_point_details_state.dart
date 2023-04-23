part of 'grammar_point_details_bloc.dart';

@freezed
class GrammarPointDetailsState with _$GrammarPointDetailsState {
  const factory GrammarPointDetailsState.initial() = GrammarPointDetailsInitial;
  const factory GrammarPointDetailsState.loading() = GrammarPointDetailsLoading;
  const factory GrammarPointDetailsState.loaded(GrammarPoint grammarPoint) =
      GrammarPointDetailsLoaded;
  const factory GrammarPointDetailsState.removed() = GrammarPointDetailsRemoved;
  const factory GrammarPointDetailsState.error(String message) =
      GrammarPointDetailsError;
}
