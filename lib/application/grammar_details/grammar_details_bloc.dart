import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';

part 'grammar_details_event.dart';
part 'grammar_details_state.dart';

@lazySingleton
class GrammarPointDetailsBloc
    extends Bloc<GrammarPointDetailsEvent, GrammarPointDetailsState> {
  final IGrammarPointRepository _grammarPointRepository;

  GrammarPointDetailsBloc(this._grammarPointRepository)
      : super(GrammarPointDetailsStateIdle()) {
    on<GrammarPointDetailsEventLoading>((event, emit) async {
      try {
        emit(GrammarPointDetailsStateLoading());
        final grammarPoint = await _grammarPointRepository.getGrammarPoint(
            event.grammarPoint.listName, event.grammarPoint.name);
        emit(GrammarPointDetailsStateLoaded(grammarPoint: grammarPoint));
      } on Exception {
        emit(const GrammarPointDetailsStateFailure(error: ":("));
      }
    });

    on<GrammarPointDetailsEventDelete>((event, emit) async {
      final k = event.grammarPoint;
      if (state is GrammarPointDetailsStateLoaded && k != null) {
        final int code = await _grammarPointRepository.removeGrammarPoint(
            k.listName, k.name);
        if (code == 0) {
          // TODO: Show grammar win rates on KanList?
          emit(GrammarPointDetailsStateRemoved());
        } else if (code == 1) {
          emit(GrammarPointDetailsStateFailure(
              error:
                  "grammar_bottom_sheet_createDialogForDeletingGrammar_removal_failed"
                      .tr()));
        } else {
          emit(GrammarPointDetailsStateFailure(
              error:
                  "grammar_bottom_sheet_createDialogForDeletingGrammar_failed"
                      .tr()));
        }
      } else {
        emit(GrammarPointDetailsStateFailure(
            error:
                "grammar_bottom_sheet_createDialogForDeletingGrammar_removal_failed"
                    .tr()));
      }
    });
  }
}
