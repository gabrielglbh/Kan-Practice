import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'word_details_event.dart';
part 'word_details_state.dart';

part 'word_details_bloc.freezed.dart';

/// This bloc is used in word_lists.dart and jisho.dart
@injectable
class WordDetailsBloc extends Bloc<WordDetailsEvent, WordDetailsState> {
  final IListRepository _listRepository;
  final IWordRepository _wordRepository;

  WordDetailsBloc(
    this._listRepository,
    this._wordRepository,
  ) : super(const WordDetailsState.initial()) {
    on<WordDetailsEventLoading>((event, emit) async {
      try {
        emit(const WordDetailsState.loading());
        if (event.isArchive) {
          final word = await _wordRepository.getWord(
            event.word.word,
            meaning: event.word.meaning,
          );
          emit(WordDetailsState.loaded(word));
        } else {
          final word = await _wordRepository.getWord(
            event.word.word,
            listName: event.word.listName,
          );
          emit(WordDetailsState.loaded(word));
        }
      } on Exception {
        emit(const WordDetailsState.error(":("));
      }
    });

    on<WordDetailsEventDelete>((event, emit) async {
      final k = event.word;
      if (state is WordDetailsLoaded && k != null) {
        final int code = await _wordRepository.removeWord(k.listName, k.word);
        if (code == 0) {
          WordList list = await _listRepository.getList(k.listName);
          List<Word> words =
              await _wordRepository.getAllWordsFromList(k.listName);

          /// TODO: If a new GrammarMode is added, modify this
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
          } else if (list.totalWinRateWriting !=
                  DatabaseConstants.emptyWinRate ||
              list.totalWinRateReading != DatabaseConstants.emptyWinRate ||
              list.totalWinRateRecognition != DatabaseConstants.emptyWinRate ||
              list.totalWinRateListening != DatabaseConstants.emptyWinRate ||
              list.totalWinRateSpeaking != DatabaseConstants.emptyWinRate) {
            /// Get the y value: total length of list prior to addition of
            /// word multiplied by the overall win rate
            final wy = (words.length + 1) * list.totalWinRateWriting;
            final ry = (words.length + 1) * list.totalWinRateReading;
            final rey = (words.length + 1) * list.totalWinRateRecognition;
            final ly = (words.length + 1) * list.totalWinRateListening;
            final sy = (words.length + 1) * list.totalWinRateSpeaking;

            /// Add the winRate of the added word to y
            final wPartialScore = wy - k.winRateWriting;
            final rPartialScore = ry - k.winRateReading;
            final rePartialScore = rey - k.winRateRecognition;
            final lPartialScore = ly - k.winRateListening;
            final sPartialScore = sy - k.winRateSpeaking;

            /// Calculate the new overall score with the partialScore divideds
            /// by the list with the word
            final wNewScore = wPartialScore / words.length;
            final readNewScore = rPartialScore / words.length;
            final recNewScore = rePartialScore / words.length;
            final lisNewScore = lPartialScore / words.length;
            final speakNewScore = sPartialScore / words.length;

            await _listRepository.updateList(k.listName, {
              ListTableFields.totalWinRateWritingField: wNewScore,
              ListTableFields.totalWinRateReadingField: readNewScore,
              ListTableFields.totalWinRateRecognitionField: recNewScore,
              ListTableFields.totalWinRateListeningField: lisNewScore,
              ListTableFields.totalWinRateSpeakingField: speakNewScore
            });
          }
          emit(const WordDetailsState.removed());
        } else if (code == 1) {
          emit(WordDetailsState.error(
              "word_bottom_sheet_createDialogForDeletingWord_removal_failed"
                  .tr()));
        } else {
          emit(WordDetailsState.error(
              "word_bottom_sheet_createDialogForDeletingWord_failed".tr()));
        }
      } else {
        emit(WordDetailsState.error(
            "word_bottom_sheet_createDialogForDeletingWord_removal_failed"
                .tr()));
      }
    });
  }
}
