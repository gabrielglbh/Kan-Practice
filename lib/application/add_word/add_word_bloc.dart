import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'add_word_event.dart';
part 'add_word_state.dart';

part 'add_word_bloc.freezed.dart';

@lazySingleton
class AddWordBloc extends Bloc<AddWordEvent, AddWordState> {
  final IWordRepository _wordyRepository;

  AddWordBloc(this._wordyRepository) : super(const AddWordState.initial()) {
    on<AddWordEventUpdate>((event, emit) async {
      emit(const AddWordState.loading());
      final code = await _wordyRepository.updateWord(
          event.listName, event.wordPk, event.parameters);
      if (code == 0) {
        emit(const AddWordState.updateDone());
      } else if (code == -1) {
        emit(AddWordState.error("add_word_updateWord_failed_update".tr()));
      } else {
        emit(AddWordState.error("add_word_updateWord_failed".tr()));
      }
    });

    on<AddWordEventCreate>((event, emit) async {
      emit(const AddWordState.loading());
      final code = await _wordyRepository.createWord(event.word);
      if (code == 0) {
        emit(AddWordState.creationDone(event.exitMode));
      } else if (code == -1) {
        emit(AddWordState.error("add_word_createWord_failed_insertion".tr()));
      } else {
        emit(AddWordState.error("add_word_createWord_failed".tr()));
      }
    });
  }
}
