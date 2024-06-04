import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';

part 'grammar_point_details_event.dart';
part 'grammar_point_details_state.dart';

part 'grammar_point_details_bloc.freezed.dart';

@injectable
class GrammarPointDetailsBloc
    extends Bloc<GrammarPointDetailsEvent, GrammarPointDetailsState> {
  final IGrammarPointRepository _grammarPointRepository;
  final IListRepository _listRepository;

  GrammarPointDetailsBloc(this._grammarPointRepository, this._listRepository)
      : super(const GrammarPointDetailsState.initial()) {
    on<GrammarPointDetailsEventLoading>((event, emit) async {
      try {
        emit(const GrammarPointDetailsState.loading());
        if (event.isArchive) {
          final grammarPoint = await _grammarPointRepository.getGrammarPoint(
              event.grammarPoint.name,
              definition: event.grammarPoint.definition);
          emit(GrammarPointDetailsState.loaded(grammarPoint));
        } else {
          final grammarPoint = await _grammarPointRepository.getGrammarPoint(
              event.grammarPoint.name,
              listName: event.grammarPoint.listName);
          emit(GrammarPointDetailsState.loaded(grammarPoint));
        }
      } on Exception {
        emit(const GrammarPointDetailsState.error(":("));
      }
    });

    on<GrammarPointDetailsEventDelete>((event, emit) async {
      final k = event.grammarPoint;
      if (state is GrammarPointDetailsLoaded && k != null) {
        final int code = await _grammarPointRepository.removeGrammarPoint(
            k.listName, k.name);
        if (code == 0) {
          final list = await _listRepository.getList(k.listName);
          List<GrammarPoint> grammarPoints = await _grammarPointRepository
              .getAllGrammarPointsFromList(k.listName);

          /// TODO: If a new GrammarMode is added, modify this
          /// Update for each mode the overall score again. Issue: #10
          ///
          /// For each mode, recalculate the overall score based on the
          /// winRates of the value to be deleted and the new KanList length.
          /// It takes into account the empty values.
          ///
          /// If list is empty, update all values to -1.
          if (grammarPoints.isEmpty) {
            await _listRepository.updateList(k.listName, {
              ListTableFields.totalWinRateDefinitionField:
                  DatabaseConstants.emptyWinRate,
              ListTableFields.totalWinRateGrammarPointField:
                  DatabaseConstants.emptyWinRate,
            });
          } else if (list.totalWinRateDefinition !=
                  DatabaseConstants.emptyWinRate ||
              list.totalWinRateGrammarPoint != DatabaseConstants.emptyWinRate) {
            /// Get the y value: total length of list prior to addition of
            /// word multiplied by the overall win rate
            final dy = (grammarPoints.length + 1) * list.totalWinRateDefinition;
            final gpy =
                (grammarPoints.length + 1) * list.totalWinRateGrammarPoint;

            /// Add the winRate of the added word to y
            final dPartialScore = dy - k.winRateDefinition;
            final gpPartialScore = gpy - k.winRateGrammarPoint;

            /// Calculate the new overall score with the partialScore divideds
            /// by the list with the word
            final dNewScore = dPartialScore / grammarPoints.length;
            final pNewScore = gpPartialScore / grammarPoints.length;

            await _listRepository.updateList(k.listName, {
              ListTableFields.totalWinRateDefinitionField: dNewScore,
              ListTableFields.totalWinRateGrammarPointField: pNewScore
            });
          }
          emit(const GrammarPointDetailsState.removed());
        } else if (code == 1) {
          emit(GrammarPointDetailsState.error(
              "grammar_bottom_sheet_createDialogForDeletingGrammar_removal_failed"
                  .tr()));
        } else {
          emit(GrammarPointDetailsState.error(
              "grammar_bottom_sheet_createDialogForDeletingGrammar_failed"
                  .tr()));
        }
      } else {
        emit(GrammarPointDetailsState.error(
            "grammar_bottom_sheet_createDialogForDeletingGrammar_removal_failed"
                .tr()));
      }
    });
  }
}
