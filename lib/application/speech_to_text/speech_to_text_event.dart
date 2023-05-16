part of 'speech_to_text_bloc.dart';

abstract class SpeechToTextEvent extends Equatable {
  const SpeechToTextEvent();

  @override
  List<Object> get props => [];
}

class SpeechToTextEventSetUp extends SpeechToTextEvent {}

class SpeechToTextEventListening extends SpeechToTextEvent {}
