part of 'grammar_mode_bloc.dart';

@freezed
class GrammarModeState with _$GrammarModeState {
  const factory GrammarModeState.loaded() = GrammarModeLoaded;
  const factory GrammarModeState.sm2Calculated() = GrammarModeSM2Calculated;
  const factory GrammarModeState.scoreCalculated(int score) =
      GrammarModeScoreCalculated;
  const factory GrammarModeState.scoreObtained(double score) =
      GrammarModeScoreObtained;
}
