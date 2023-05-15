part of 'study_mode_bloc.dart';

abstract class StudyModeEvent extends Equatable {
  const StudyModeEvent();

  @override
  List<Object> get props => [];
}

class StudyModeEventCalculateScore extends StudyModeEvent {
  final StudyModes mode;
  final double score;
  final Word word;
  final bool isTest;

  const StudyModeEventCalculateScore(
    this.mode,
    this.word,
    this.score, {
    this.isTest = false,
  });

  @override
  List<Object> get props => [mode, score, word];
}

class StudyModeEventCalculateSM2Params extends StudyModeEvent {
  final StudyModes mode;
  final double score;
  final Word word;

  const StudyModeEventCalculateSM2Params(this.mode, this.word, this.score);

  @override
  List<Object> get props => [mode, score, word];
}

class StudyModeEventUpdateScoreForTestsAffectingPractice
    extends StudyModeEvent {
  final List<Word> words;
  final StudyModes mode;
  final bool shouldAffectPractice;

  const StudyModeEventUpdateScoreForTestsAffectingPractice(
      this.words, this.mode, this.shouldAffectPractice);

  @override
  List<Object> get props => [words, mode, shouldAffectPractice];
}

class StudyModeEventGetScore extends StudyModeEvent {
  final StudyModes mode;
  final String listName;

  const StudyModeEventGetScore(this.listName, this.mode);

  @override
  List<Object> get props => [listName, mode];
}

class StudyModeEventUpdateListScore extends StudyModeEvent {
  final double score;
  final StudyModes mode;
  final String listName;

  const StudyModeEventUpdateListScore(this.score, this.listName, this.mode);

  @override
  List<Object> get props => [score, listName, mode];
}

class StudyModeEventResetTracking extends StudyModeEvent {}
