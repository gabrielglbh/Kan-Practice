part of 'test_result_bloc.dart';

@freezed
class TestResultState with _$TestResultState {
  const factory TestResultState.saved() = TestResultSaved;
  const factory TestResultState.initial() = TestResultInitial;
  const factory TestResultState.saving() = TestResultSaving;
}
