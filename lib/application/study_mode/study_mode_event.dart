part of 'study_mode_bloc.dart';

abstract class StudyModeEvent extends Equatable {
  const StudyModeEvent();

  @override
  List<Object> get props => [];
}

class StudyModeEventUpdateDateShown extends StudyModeEvent {
  final String listName;
  final String word;

  const StudyModeEventUpdateDateShown(
      {required this.listName, required this.word});

  @override
  List<Object> get props => [listName, word];
}

class StudyModeEventCalculateScore extends StudyModeEvent {
  final StudyModes mode;
  final double score;
  final Word word;

  const StudyModeEventCalculateScore(this.mode, this.word, this.score);

  @override
  List<Object> get props => [mode, score, word];
}

class StudyModeEventUpdateScoreForTestsAffectingPractice
    extends StudyModeEvent {
  final List<Word> words;
  final StudyModes mode;

  const StudyModeEventUpdateScoreForTestsAffectingPractice(
      this.words, this.mode);

  @override
  List<Object> get props => [words, mode];
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
