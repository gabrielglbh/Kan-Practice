part of 'grammar_test_bloc.dart';

@freezed
class GrammarTestState with _$GrammarTestState {
  const factory GrammarTestState.initial(List<int> grammarToReview) =
      GrammarTestInitial;
  const factory GrammarTestState.loaded(
      List<GrammarPoint> grammar, GrammarModes mode) = GrammarTestLoaded;
}
