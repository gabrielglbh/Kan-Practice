import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';

part 'add_grammar_point_event.dart';
part 'add_grammar_point_state.dart';

part 'add_grammar_point_bloc.freezed.dart';

@injectable
class AddGrammarPointBloc
    extends Bloc<AddGrammarPointEvent, AddGrammarPointState> {
  final IGrammarPointRepository _grammarPointRepository;
  final IListRepository _listRepository;

  AddGrammarPointBloc(this._grammarPointRepository, this._listRepository)
      : super(const AddGrammarPointState.initial()) {
    on<AddGrammarPointEventUpdate>((event, emit) async {
      emit(const AddGrammarPointState.loading());
      final code = await _grammarPointRepository.updateGrammarPoint(
          event.listName, event.grammarPk, event.parameters);
      if (code == 0) {
        emit(const AddGrammarPointState.updateDone());
      } else if (code == -1) {
        emit(AddGrammarPointState.error(
            "add_grammar_updateGrammar_failed_update".tr()));
      } else {
        emit(AddGrammarPointState.error(
            "add_grammar_updateGrammar_failed".tr()));
      }
    });

    on<AddGrammarPointEventCreate>((event, emit) async {
      emit(const AddGrammarPointState.loading());
      final code =
          await _grammarPointRepository.createGrammarPoint(event.grammarPoint);
      if (code == 0) {
        final k = event.grammarPoint;
        WordList list = await _listRepository.getList(k.listName);
        List<GrammarPoint> grammarPoints = await _grammarPointRepository
            .getAllGrammarPointsFromList(k.listName);

        /// TODO: If a new GrammarMode is added, modify this
        /// Update for each mode the overall score again. Issue: #10
        ///
        /// For each mode, recalculate the overall score based on the
        /// winRates of the value to be deleted and the new KanList length.
        /// It takes into account the empty values.
        ///
        /// If the list contains any winRate other than `emptyWinRate`, then update
        /// on addition. Else, the list is newly created and there is no need to
        /// touch it as the win rates will still be -1.
        if (list.totalWinRateDefinition != DatabaseConstants.emptyWinRate ||
            list.totalWinRateGrammarPoint != DatabaseConstants.emptyWinRate) {
          /// Get the y value: total length of list prior to addition of
          /// word multiplied by the overall win rate
          final dy = (grammarPoints.length - 1) * list.totalWinRateDefinition;
          final gpy =
              (grammarPoints.length - 1) * list.totalWinRateGrammarPoint;

          /// Add the winRate of the added word to y
          final dPartialScore = dy + k.winRateDefinition;
          final gpPartialScore = gpy + k.winRateGrammarPoint;

          /// Calculate the new overall score with the partialScore divideds
          /// by the list with the word
          final dNewScore = dPartialScore / grammarPoints.length;
          final pNewScore = gpPartialScore / grammarPoints.length;

          await _listRepository.updateList(k.listName, {
            ListTableFields.totalWinRateDefinitionField: dNewScore,
            ListTableFields.totalWinRateGrammarPointField: pNewScore
          });
        }

        emit(AddGrammarPointState.creationDone(event.exitMode));
      } else if (code == -1) {
        emit(AddGrammarPointState.error(
            "add_grammar_createGrammar_failed_insertion".tr()));
      } else {
        emit(AddGrammarPointState.error(
            "add_grammar_createGrammar_failed".tr()));
      }
    });
  }
}
