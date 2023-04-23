part of 'dictionary_bloc.dart';

abstract class DictionaryEvent extends Equatable {
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class DictionaryEventLoading extends DictionaryEvent {
  final Image image;

  const DictionaryEventLoading({required this.image});

  @override
  List<Object> get props => [];
}

class DictionaryEventStart extends DictionaryEvent {}
