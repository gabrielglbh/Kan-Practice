import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/infrastructure/word/word_repository_impl.dart';
import 'package:kanpractice/injection.dart';

part 'add_kanji_event.dart';
part 'add_kanji_state.dart';

@lazySingleton
class AddKanjiBloc extends Bloc<AddKanjiEvent, AddKanjiState> {
  AddKanjiBloc() : super(AddKanjiStateIdle()) {
    on<AddKanjiEventIdle>((event, emit) {});

    on<AddKanjiEventUpdate>((event, emit) async {
      final code = await getIt<WordRepositoryImpl>()
          .updateWord(event.listName, event.kanjiPk, event.parameters);
      if (code == 0) {
        emit(AddKanjiStateDoneUpdating());
      } else if (code == -1) {
        emit(AddKanjiStateFailure(
            message: "add_kanji_updateKanji_failed_update".tr()));
      } else {
        emit(
            AddKanjiStateFailure(message: "add_kanji_updateKanji_failed".tr()));
      }
    });

    on<AddKanjiEventCreate>((event, emit) async {
      emit(AddKanjiStateLoading());
      final code = await getIt<WordRepositoryImpl>().createWord(event.kanji);
      if (code == 0) {
        emit(AddKanjiStateDoneCreating(exitMode: event.exitMode));
      } else if (code == -1) {
        emit(AddKanjiStateFailure(
            message: "add_kanji_createKanji_failed_insertion".tr()));
      } else {
        emit(
            AddKanjiStateFailure(message: "add_kanji_createKanji_failed".tr()));
      }
    });
  }
}
