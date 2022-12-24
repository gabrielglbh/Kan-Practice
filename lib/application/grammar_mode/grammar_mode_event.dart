part of 'grammar_mode_bloc.dart';

abstract class GrammarModeEvent extends Equatable {
  const GrammarModeEvent();

  @override
  List<Object> get props => [];
}

class GrammarModeEventUpdateDateShown extends GrammarModeEvent {
  final String listName;
  final String name;
  final GrammarModes mode;

  const GrammarModeEventUpdateDateShown({
    required this.listName,
    required this.name,
    required this.mode,
  });

  @override
  List<Object> get props => [listName, name, mode];
}

class GrammarModeEventCalculateScore extends GrammarModeEvent {
  final GrammarModes mode;
  final double score;
  final GrammarPoint grammarPoint;

  const GrammarModeEventCalculateScore(
      this.mode, this.grammarPoint, this.score);

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

  const GrammarModeEventUpdateScoreForTestsAffectingPractice(
      this.grammarPoints, this.mode);

  @override
  List<Object> get props => [grammarPoints, mode];
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