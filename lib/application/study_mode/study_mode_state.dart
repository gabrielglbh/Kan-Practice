part of 'study_mode_bloc.dart';

@freezed
class StudyModeState with _$StudyModeState {
  const factory StudyModeState.loading() = StudyModeLoading;
  const factory StudyModeState.loaded() = StudyModeLoaded;
  const factory StudyModeState.sm2Calculated() = StudyModeSM2Calculated;
  const factory StudyModeState.scoreCalculated(int score) =
      StudyModeScoreCalculated;
  const factory StudyModeState.scoreObtained(double score) =
      StudyModeScoreObtained;
  const factory StudyModeState.testFinished() = StudyModeTestFinished;
}
