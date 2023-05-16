import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/speech_to_text/i_speech_to_text_repository.dart';

part 'speech_to_text_event.dart';
part 'speech_to_text_state.dart';

part 'speech_to_text_bloc.freezed.dart';

@lazySingleton
class SpeechToTextBloc extends Bloc<SpeechToTextEvent, SpeechToTextState> {
  final ISpeechToTextRepository _repository;

  bool _available = false;

  SpeechToTextBloc(this._repository)
      : super(const SpeechToTextState.initial()) {
    on<SpeechToTextEventSetUp>((event, emit) async {
      if (_available) {
        emit(const SpeechToTextState.available());
      } else {
        _available = await _repository.setUp();
        emit(const SpeechToTextState.available());
      }
    });

    on<SpeechToTextEventListening>((event, emit) async {
      if (!_available) {
        emit(const SpeechToTextState.error());
      } else {
        emit(const SpeechToTextState.listening());
        final words = await _repository.recognize();
        emit(SpeechToTextState.providedWords(words));
      }
    });
  }
}
