part of 'dictionary_bloc.dart';

abstract class DictionaryEvent extends Equatable {
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class DictionaryEventLoading extends DictionaryEvent {
  final ByteData data;

  const DictionaryEventLoading({required this.data});

  @override
  List<Object> get props => [data];
}

class DictionaryEventStart extends DictionaryEvent {}
