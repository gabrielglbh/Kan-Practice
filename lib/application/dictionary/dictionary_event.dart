part of 'dictionary_bloc.dart';

abstract class DictionaryEvent extends Equatable {
  const DictionaryEvent();

  @override
  List<Object> get props => [];
}

class DictionaryEventLoading extends DictionaryEvent {
  final ByteData data;
  final Size size;

  const DictionaryEventLoading({required this.data, required this.size});

  @override
  List<Object> get props => [data, size];
}

class DictionaryEventStart extends DictionaryEvent {}
