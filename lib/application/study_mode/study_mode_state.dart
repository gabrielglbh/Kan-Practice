part of 'study_mode_bloc.dart';

class StudyModeState extends Equatable {
  const StudyModeState();

  @override
  List<Object?> get props => [];
}

class StudyModeStateLoading extends StudyModeState {}

class StudyModeStateLoaded extends StudyModeState {}

class StudyModeStateScoreCalculated extends StudyModeState {
  final int score;

  const StudyModeStateScoreCalculated(this.score);

  @override
  List<Object?> get props => [score];
}

class StudyModeStateScoreObtained extends StudyModeState {
  final double score;

  const StudyModeStateScoreObtained(this.score);

  @override
  List<Object?> get props => [score];
}
