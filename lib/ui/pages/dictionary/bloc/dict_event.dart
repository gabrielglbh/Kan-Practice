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

class DictEventIdle extends DictEvent {}