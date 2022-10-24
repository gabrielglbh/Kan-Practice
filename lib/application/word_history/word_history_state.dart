part of 'word_history_bloc.dart';

class WordHistoryState extends Equatable {
  const WordHistoryState();

  @override
  List<Object?> get props => [];
}

class WordHistoryStateIdle extends WordHistoryState {}

class WordHistoryStateLoading extends WordHistoryState {}

class WordHistoryStateLoaded extends WordHistoryState {
  final List<WordHistory> list;

  const WordHistoryStateLoaded([this.list = const []]);

  @override
  List<Object> get props => [list];
}

class WordHistoryStateFailure extends WordHistoryState {}
