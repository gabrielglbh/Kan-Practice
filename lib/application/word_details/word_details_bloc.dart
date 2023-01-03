import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'word_details_event.dart';
part 'word_details_state.dart';

/// This bloc is used in kanji_lists.dart and jisho.dart
@lazySingleton
class WordDetailsBloc extends Bloc<WordDetailsEvent, WordDetailsState> {
  final IListRepository _listRepository;
  final IWordRepository _wordRepository;

  WordDetailsBloc(
    this._listRepository,
    this._wordRepository,
  ) : super(WordDetailsStateIdle()) {
    on<WordDetailsEventLoading>((event, emit) async {
      try {
        emit(WordDetailsStateLoading());
        if (event.isArchive) {
          final kanji = await _wordRepository.getWord(
            event.word.word,
            meaning: event.word.meaning,
          );
          emit(WordDetailsStateLoaded(kanji: kanji));
        } else {
          final kanji = await _wordRepository.getWord(
            event.word.word,
            listName: event.word.listName,
          );
          emit(WordDetailsStateLoaded(kanji: kanji));
        }
      } on Exception {
        emit(const WordDetailsStateFailure(error: ":("));
      }
    });

    on<WordDetailsEventDelete>((event, emit) async {
      final k = event.word;
      if (state is WordDetailsStateLoaded && k != null) {
        final int code = await _wordRepository.removeWord(k.listName, k.word);
        if (code == 0) {
          WordList list = await _listRepository.getList(k.listName);
          List<Word> words =
              await _wordRepository.getAllWordsFromList(k.listName);

          /// Update for each mode the overall score again. Issue: #10
          ///
          /// For each mode, recalculate the overall score based on the
          /// winRates of the value to be deleted and the new KanList length.
          /// It takes into account the empty values.
          ///
          /// If list is empty, update all values to -1.
          if (words.isEmpty) {
            await _listRepository.updateList(k.listName, {
              ListTableFields.totalWinRateWritingField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateReadingField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateRecognitionField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateListeningField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateSpeakingField:
                  DatabaseConstants.emptyWinRate
            });
          } else {
            double wNewScore = list.totalWinRateWriting;
            double readNewScore = list.totalWinRateReading;
            double recNewScore = list.totalWinRateRecognition;
            double lisNewScore = list.totalWinRateListening;
            double speakNewScore = list.totalWinRateSpeaking;

            if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
              /// Get the y value: total length of list prior to removal of
              /// kanji multiplied by the overall win rate
              double y = (words.length + 1) * list.totalWinRateWriting;

              /// Subtract the winRate of the removed kanji to y
              double partialScore = y - k.winRateWriting;

              /// Calculate the new overall score with the partialScore divided
              /// by the list without the kanji
              wNewScore = partialScore / words.length;
            }
            if (k.winRateReading != DatabaseConstants.emptyWinRate) {
              double y = (words.length + 1) * list.totalWinRateReading;
              double partialScore = y - k.winRateReading;
              readNewScore = partialScore / words.length;
            }
            if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
              double y = (words.length + 1) * list.totalWinRateRecognition;
              double partialScore = y - k.winRateRecognition;
              recNewScore = partialScore / words.length;
            }
            if (k.winRateListening != DatabaseConstants.emptyWinRate) {
              double y = (words.length + 1) * list.totalWinRateListening;
              double partialScore = y - k.winRateListening;
              lisNewScore = partialScore / words.length;
            }
            if (k.winRateSpeaking != DatabaseConstants.emptyWinRate) {
              double y = (words.length + 1) * list.totalWinRateSpeaking;
              double partialScore = y - k.winRateSpeaking;
              speakNewScore = partialScore / words.length;
            }

            await _listRepository.updateList(k.listName, {
              ListTableFields.totalWinRateWritingField: wNewScore,
              ListTableFields.totalWinRateReadingField: readNewScore,
              ListTableFields.totalWinRateRecognitionField: recNewScore,
              ListTableFields.totalWinRateListeningField: lisNewScore,
              ListTableFields.totalWinRateSpeakingField: speakNewScore
            });
          }
          emit(WordDetailsStateRemoved());
        } else if (code == 1) {
          emit(WordDetailsStateFailure(
              error:
                  "kanji_bottom_sheet_createDialogForDeletingKanji_removal_failed"
                      .tr()));
        } else {
          emit(WordDetailsStateFailure(
              error: "kanji_bottom_sheet_createDialogForDeletingKanji_failed"
                  .tr()));
        }
      } else {
        emit(WordDetailsStateFailure(
            error:
                "kanji_bottom_sheet_createDialogForDeletingKanji_removal_failed"
                    .tr()));
      }
    });
  }
}
