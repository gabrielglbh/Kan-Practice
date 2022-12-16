import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';

part 'add_grammar_point_event.dart';
part 'add_grammar_point_state.dart';

@lazySingleton
class AddGrammarPointBloc
    extends Bloc<AddGrammarPointEvent, AddGrammarPointState> {
  final IGrammarPointRepository _grammarPointRepository;

  AddGrammarPointBloc(this._grammarPointRepository)
      : super(AddGrammarPointStateIdle()) {
    on<AddGrammarPointEventUpdate>((event, emit) async {
      final code = await _grammarPointRepository.updateGrammarPoint(
          event.listName, event.grammarPk, event.parameters);
      if (code == 0) {
        emit(AddGrammarPointStateDoneUpdating());
      } else if (code == -1) {
        emit(AddGrammarPointStateFailure(
            message: "add_grammar_updateGrammar_failed_update".tr()));
      } else {
        emit(AddGrammarPointStateFailure(
            message: "add_grammar_updateGrammar_failed".tr()));
      }
    });

    on<AddGrammarPointEventCreate>((event, emit) async {
      emit(AddGrammarPointStateLoading());
      final code =
          await _grammarPointRepository.createGrammarPoint(event.grammarPoint);
      if (code == 0) {
        emit(AddGrammarPointStateDoneCreating(exitMode: event.exitMode));
      } else if (code == -1) {
        emit(AddGrammarPointStateFailure(
            message: "add_grammar_createGrammar_failed_insertion".tr()));
      } else {
        emit(AddGrammarPointStateFailure(
            message: "add_grammar_createGrammar_failed".tr()));
      }
    });
  }
}
