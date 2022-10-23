import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'word_details_event.dart';
part 'word_details_state.dart';

/// This bloc is used in kanji_lists.dart and jisho.dart
class WordDetailsBloc extends Bloc<WordDetailsEvent, WordDetailsState> {
  WordDetailsBloc() : super(WordDetailsStateLoading()) {
    on<WordDetailsEventLoading>((event, emit) async {
      try {
        emit(WordDetailsStateLoading());
        final kanji = await WordQueries.instance
            .getKanji(event.word.listName, event.word.word);
        emit(WordDetailsStateLoaded(kanji: kanji));
      } on Exception {
        emit(const WordDetailsStateFailure(error: ":("));
      }
    });

    on<WordDetailsEventDelete>((event, emit) async {
      final k = event.word;
      if (state is WordDetailsStateLoaded && k != null) {
        final int code =
            await WordQueries.instance.removeKanji(k.listName, k.word);
        if (code == 0) {
          WordList list = await ListQueries.instance.getList(k.listName);
          List<Word> words =
              await WordQueries.instance.getAllKanjiFromList(k.listName);

          /// Update for each mode the overall score again. Issue: #10
          ///
          /// For each mode, recalculate the overall score based on the
          /// winRates of the value to be deleted and the new KanList length.
          /// It takes into account the empty values.
          ///
          /// If list is empty, update all values to -1.
          if (words.isEmpty) {
            await ListQueries.instance.updateList(k.listName, {
              ListTableFields.totalWinRateWritingField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateReadingField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateRecognitionField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateListeningField:
                  DatabaseConstants.emptyWinRate
            });
          } else {
            double wNewScore = list.totalWinRateWriting;
            double readNewScore = list.totalWinRateReading;
            double recNewScore = list.totalWinRateRecognition;
            double lisNewScore = list.totalWinRateListening;

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

            await ListQueries.instance.updateList(k.listName, {
              ListTableFields.totalWinRateWritingField: wNewScore,
              ListTableFields.totalWinRateReadingField: readNewScore,
              ListTableFields.totalWinRateRecognitionField: recNewScore,
              ListTableFields.totalWinRateListeningField: lisNewScore
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
