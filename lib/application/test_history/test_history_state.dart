part of 'test_history_bloc.dart';

@freezed
class TestHistoryState with _$TestHistoryState {
  const factory TestHistoryState.loaded(List<Test> list) = TestHistoryLoaded;
  const factory TestHistoryState.loading() = TestHistoryLoading;
  const factory TestHistoryState.initial() = TestHistoryInitial;
  const factory TestHistoryState.error() = TestHistoryError;
}
