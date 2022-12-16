part of 'grammar_mode_bloc.dart';

class GrammarModeState extends Equatable {
  const GrammarModeState();

  @override
  List<Object?> get props => [];
}

class GrammarModeStateLoading extends GrammarModeState {}

class GrammarModeStateLoaded extends GrammarModeState {}

class GrammarModeStateSM2Calculated extends GrammarModeState {}

class GrammarModeStateScoreCalculated extends GrammarModeState {
  final int score;

  const GrammarModeStateScoreCalculated(this.score);

  @override
  List<Object?> get props => [score];
}

class GrammarModeStateScoreObtained extends GrammarModeState {
  final double score;

  const GrammarModeStateScoreObtained(this.score);

  @override
  List<Object?> get props => [score];
}
