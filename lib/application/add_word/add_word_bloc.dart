import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'add_word_event.dart';
part 'add_word_state.dart';

@lazySingleton
class AddWordBloc extends Bloc<AddWordEvent, AddWordState> {
  final IWordRepository _wordyRepository;

  AddWordBloc(this._wordyRepository) : super(AddWordStateIdle()) {
    on<AddWordEventUpdate>((event, emit) async {
      emit(AddWordStateLoading());
      final code = await _wordyRepository.updateWord(
          event.listName, event.wordPk, event.parameters);
      if (code == 0) {
        emit(AddWordStateDoneUpdating());
      } else if (code == -1) {
        emit(AddWordStateFailure(
            message: "add_word_updateWord_failed_update".tr()));
      } else {
        emit(AddWordStateFailure(message: "add_word_updateWord_failed".tr()));
      }
    });

    on<AddWordEventCreate>((event, emit) async {
      emit(AddWordStateLoading());
      final code = await _wordyRepository.createWord(event.word);
      if (code == 0) {
        emit(AddWordStateDoneCreating(exitMode: event.exitMode));
      } else if (code == -1) {
        emit(AddWordStateFailure(
            message: "add_word_createWord_failed_insertion".tr()));
      } else {
        emit(AddWordStateFailure(message: "add_word_createWord_failed".tr()));
      }
    });
  }
}
