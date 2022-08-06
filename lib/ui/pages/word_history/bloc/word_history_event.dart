part of 'word_history_bloc.dart';

abstract class WordHistoryEvent extends Equatable {
  const WordHistoryEvent();

  @override
  List<Object> get props => [];
}

class WordHistoryEventLoading extends WordHistoryEvent {
  final int offset;

  const WordHistoryEventLoading({this.offset = 0});

  @override
  List<Object> get props => [offset];
}

class WordHistoryEventRemoving extends WordHistoryEvent {}
