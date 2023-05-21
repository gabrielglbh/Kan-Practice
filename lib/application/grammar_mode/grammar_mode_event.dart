part of 'grammar_mode_bloc.dart';

abstract class GrammarModeEvent extends Equatable {
  const GrammarModeEvent();

  @override
  List<Object> get props => [];
}

class GrammarModeEventCalculateScore extends GrammarModeEvent {
  final GrammarModes mode;
  final double score;
  final GrammarPoint grammarPoint;
  final bool isTest;

  const GrammarModeEventCalculateScore(
    this.mode,
    this.grammarPoint,
    this.score, {
    this.isTest = false,
  });

  @override
  List<Object> get props => [mode, score, grammarPoint];
}

class GrammarModeEventCalculateSM2Params extends GrammarModeEvent {
  final GrammarModes mode;
  final double score;
  final GrammarPoint grammarPoint;

  const GrammarModeEventCalculateSM2Params(
      this.mode, this.grammarPoint, this.score);

  @override
  List<Object> get props => [mode, score, grammarPoint];
}

class GrammarModeEventUpdateScoreForTestsAffectingPractice
    extends GrammarModeEvent {
  final List<GrammarPoint> grammarPoints;
  final GrammarModes mode;
  final bool shouldAffectPractice;

  const GrammarModeEventUpdateScoreForTestsAffectingPractice(
      this.grammarPoints, this.mode, this.shouldAffectPractice);

  @override
  List<Object> get props => [grammarPoints, mode, shouldAffectPractice];
}

class GrammarModeEventGetScore extends GrammarModeEvent {
  final GrammarModes mode;
  final String listName;

  const GrammarModeEventGetScore(this.listName, this.mode);

  @override
  List<Object> get props => [listName, mode];
}

class GrammarModeEventUpdateListScore extends GrammarModeEvent {
  final double score;
  final GrammarModes mode;
  final String listName;

  const GrammarModeEventUpdateListScore(this.score, this.listName, this.mode);

  @override
  List<Object> get props => [score, listName, mode];
}

class GrammarModeEventResetTracking extends GrammarModeEvent {}
