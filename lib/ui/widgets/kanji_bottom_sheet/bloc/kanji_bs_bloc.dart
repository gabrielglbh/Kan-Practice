import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:easy_localization/easy_localization.dart';

part 'kanji_bs_event.dart';
part 'kanji_bs_state.dart';

/// This bloc is used in kanji_lists.dart and jisho.dart
class KanjiBSBloc extends Bloc<KanjiBSEvent, KanjiBSState> {
  KanjiBSBloc() : super(KanjiBSStateLoading()) {
    on<KanjiBSEventLoading>((event, emit) async {
      try {
        emit(KanjiBSStateLoading());
        final kanji = await KanjiQueries.instance
            .getKanji(event.kanji.listName, event.kanji.kanji);
        emit(KanjiBSStateLoaded(kanji: kanji));
      } on Exception {
        emit(const KanjiBSStateFailure(error: ":("));
      }
    });

    on<KanjiBSEventDelete>((event, emit) async {
      final k = event.kanji;
      if (state is KanjiBSStateLoaded && k != null) {
        final int code =
            await KanjiQueries.instance.removeKanji(k.listName, k.kanji);
        if (code == 0) {
          KanjiList kanList = await ListQueries.instance.getList(k.listName);
          List<Kanji> list =
              await KanjiQueries.instance.getAllKanjiFromList(k.listName);

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
          emit(KanjiBSStateRemoved());
        } else if (code == 1) {
          emit(KanjiBSStateFailure(
              error:
                  "kanji_bottom_sheet_createDialogForDeletingKanji_removal_failed"
                      .tr()));
        } else {
          emit(KanjiBSStateFailure(
              error: "kanji_bottom_sheet_createDialogForDeletingKanji_failed"
                  .tr()));
        }
      } else {
        emit(KanjiBSStateFailure(
            error:
                "kanji_bottom_sheet_createDialogForDeletingKanji_removal_failed"
                    .tr()));
      }
    });
  }
}
