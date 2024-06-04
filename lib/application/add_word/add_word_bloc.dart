import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/utils/mean_calculation.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'add_word_event.dart';
part 'add_word_state.dart';

part 'add_word_bloc.freezed.dart';

@lazySingleton
class AddWordBloc extends Bloc<AddWordEvent, AddWordState> {
  final IWordRepository _wordRepository;
  final IListRepository _listRepository;

  AddWordBloc(this._wordRepository, this._listRepository)
      : super(const AddWordState.initial()) {
    on<AddWordEventUpdate>((event, emit) async {
      emit(const AddWordState.loading());
      final code = await _wordRepository.updateWord(
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
      final code = await _wordRepository.createWord(event.word);
      if (code == 0) {
        final k = event.word;
        WordList list = await _listRepository.getList(k.listName);
        List<Word> words =
            await _wordRepository.getAllWordsFromList(k.listName);

        /// TODO: If a new StudyMode is addeed, modify this
        /// Update for each mode the overall score again. Issue: #10
        ///
        /// If the list contains any winRate other than `emptyWinRate`, then update
        /// on addition. Else, the list is newly created and there is no need to
        /// touch it as the win rates will still be -1.
        if (list.totalWinRateWriting != DatabaseConstants.emptyWinRate ||
            list.totalWinRateReading != DatabaseConstants.emptyWinRate ||
            list.totalWinRateRecognition != DatabaseConstants.emptyWinRate ||
            list.totalWinRateListening != DatabaseConstants.emptyWinRate ||
            list.totalWinRateSpeaking != DatabaseConstants.emptyWinRate) {
          await _listRepository.updateList(k.listName, words.studyModesMean());
        }

        emit(AddWordState.creationDone(event.exitMode));
      } else if (code == -1) {
        emit(AddWordState.error("add_word_createWord_failed_insertion".tr()));
      } else {
        emit(AddWordState.error("add_word_createWord_failed".tr()));
      }
    });
  }
}
