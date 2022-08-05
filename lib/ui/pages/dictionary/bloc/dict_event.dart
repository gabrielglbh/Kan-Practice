part of 'dict_bloc.dart';

abstract class DictEvent extends Equatable {
  const DictEvent();

  @override
  List<Object> get props => [];
}

class DictEventLoading extends DictEvent {
  final Image image;

  const DictEventLoading({required this.image});

  @override
  List<Object> get props => [];
}

class DictEventAddToHistory extends DictEvent {
  final String word;

  const DictEventAddToHistory({required this.word});

  @override
  List<Object> get props => [word];
}

class DictEventIdle extends DictEvent {}
