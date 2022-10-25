part of 'load_test_bloc.dart';

abstract class LoadTestState extends Equatable {
  const LoadTestState();

  @override
  List<Object> get props => [];
}

class LoadTestStateIdle extends LoadTestState {}

class LoadTestStateLoadedList extends LoadTestState {
  final List<Word> words;
  final StudyModes mode;

  const LoadTestStateLoadedList(this.words, this.mode);

  @override
  List<Object> get props => [words, mode];
}
