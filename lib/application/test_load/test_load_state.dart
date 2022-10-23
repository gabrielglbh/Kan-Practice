part of 'test_load_bloc.dart';

abstract class TestLoadState extends Equatable {
  const TestLoadState();

  @override
  List<Object> get props => [];
}

class TestLoadStateIdle extends TestLoadState {}

class TestLoadStateLoadedList extends TestLoadState {
  final List<Word> words;
  final StudyModes mode;

  const TestLoadStateLoadedList(this.words, this.mode);

  @override
  List<Object> get props => [words, mode];
}
