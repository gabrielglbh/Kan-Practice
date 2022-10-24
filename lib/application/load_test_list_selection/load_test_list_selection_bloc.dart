import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'load_test_list_selection_event.dart';
part 'load_test_list_selection_state.dart';

@lazySingleton
class LoadTestListSelectionBloc
    extends Bloc<LoadTestListSelectionEvent, LoadTestListSelectionState> {
  final IWordRepository _wordRepository;

  LoadTestListSelectionBloc(this._wordRepository)
      : super(LoadTestListSelectionStateIdle()) {
    on<LoadTestListSelectionEventIdle>((_, __) {});

    on<LoadTestListSelectionEventLoadList>((event, emit) async {
      List<Word> list =
          await _wordRepository.getWordBasedOnSelectedLists(event.lists);
      list.shuffle();

      final kanjiInTest = getIt<PreferencesService>()
              .readData(SharedKeys.numberOfKanjiInTest) ??
          KPSizes.numberOfKanjiInTest;
      List<Word> sortedList = list.sublist(
          0, list.length < kanjiInTest ? list.length : kanjiInTest);

      emit(LoadTestListSelectionStateLoadedList(sortedList));
    });
  }
}
