part of 'load_test_daily_bloc.dart';

abstract class LoadTestDailyState extends Equatable {
  const LoadTestDailyState();

  @override
  List<Object> get props => [];
}

class LoadTestDailyStateIdle extends LoadTestDailyState {}

class LoadTestDailyStateLoadedList extends LoadTestDailyState {
  final List<Word> words;
  final StudyModes mode;

  const LoadTestDailyStateLoadedList(this.words, this.mode);

  @override
  List<Object> get props => [words, mode];
}
