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
            .getKanji(event.kanji.listName, event.kanji.kanji);
        emit(WordDetailsStateLoaded(kanji: kanji));
      } on Exception {
        emit(const WordDetailsStateFailure(error: ":("));
      }
    });

    on<WordDetailsEventDelete>((event, emit) async {
      final k = event.kanji;
      if (state is WordDetailsStateLoaded && k != null) {
        final int code =
            await WordQueries.instance.removeKanji(k.listName, k.kanji);
        if (code == 0) {
          WordList kanList = await ListQueries.instance.getList(k.listName);
          List<Word> list =
              await WordQueries.instance.getAllKanjiFromList(k.listName);

          /// Update for each mode the overall score again. Issue: #10
          ///
          /// For each mode, recalculate the overall score based on the
          /// winRates of the value to be deleted and the new KanList length.
          /// It takes into account the empty values.
          ///
          /// If list is empty, update all values to -1.
          if (list.isEmpty) {
            await ListQueries.instance.updateList(k.listName, {
              KanListTableFields.totalWinRateWritingField:
                  DatabaseConstants.emptyWinRate,
              KanListTableFields.totalWinRateReadingField:
                  DatabaseConstants.emptyWinRate,
              KanListTableFields.totalWinRateRecognitionField:
                  DatabaseConstants.emptyWinRate,
              KanListTableFields.totalWinRateListeningField:
                  DatabaseConstants.emptyWinRate
            });
          } else {
            double wNewScore = kanList.totalWinRateWriting;
            double readNewScore = kanList.totalWinRateReading;
            double recNewScore = kanList.totalWinRateRecognition;
            double lisNewScore = kanList.totalWinRateListening;

            if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
              /// Get the y value: total length of list prior to removal of
              /// kanji multiplied by the overall win rate
              double y = (list.length + 1) * kanList.totalWinRateWriting;

              /// Subtract the winRate of the removed kanji to y
              double partialScore = y - k.winRateWriting;

              /// Calculate the new overall score with the partialScore divided
              /// by the list without the kanji
              wNewScore = partialScore / list.length;
            }
            if (k.winRateReading != DatabaseConstants.emptyWinRate) {
              double y = (list.length + 1) * kanList.totalWinRateReading;
              double partialScore = y - k.winRateReading;
              readNewScore = partialScore / list.length;
            }
            if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
              double y = (list.length + 1) * kanList.totalWinRateRecognition;
              double partialScore = y - k.winRateRecognition;
              recNewScore = partialScore / list.length;
            }
            if (k.winRateListening != DatabaseConstants.emptyWinRate) {
              double y = (list.length + 1) * kanList.totalWinRateListening;
              double partialScore = y - k.winRateListening;
              lisNewScore = partialScore / list.length;
            }

            await ListQueries.instance.updateList(k.listName, {
              KanListTableFields.totalWinRateWritingField: wNewScore,
              KanListTableFields.totalWinRateReadingField: readNewScore,
              KanListTableFields.totalWinRateRecognitionField: recNewScore,
              KanListTableFields.totalWinRateListeningField: lisNewScore
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
