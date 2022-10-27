import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'load_test_event.dart';
part 'load_test_state.dart';

@lazySingleton
class LoadTestBloc extends Bloc<LoadTestEvent, LoadTestState> {
  final IWordRepository _wordRepository;
  final IFolderRepository _folderRepository;

  LoadTestBloc(
    this._wordRepository,
    this._folderRepository,
  ) : super(LoadTestStateIdle()) {
    on<LoadTestEventLoadList>((event, emit) async {
      List<Word> finalList = [];

      if (event.practiceList == null) {
        if (event.type == Tests.folder ||
            (event.type == Tests.blitz && event.folder != null)) {
          if (event.folder != null) {
            List<Word> list = await _folderRepository
                .getAllWordsOnListsOnFolder([event.folder!]);
            list.shuffle();
            finalList = list;
          }
        } else if ((event.type == Tests.time || event.type == Tests.less) &&
            event.folder != null) {
          List<Word> list = await _folderRepository.getAllWordsOnListsOnFolder(
            [event.folder!],
            mode: event.mode,
            type: event.type,
          );
          finalList = list;
        } else if (event.type == Tests.daily) {
          List<Word> list = await _wordRepository.getDailyWords(event.mode);
          finalList = list;
        } else {
          List<Word> list = await _wordRepository.getAllWords(
              mode: event.mode, type: event.type);

          /// If it is a remembrance or less % test, do NOT shuffle the list
          if (event.type != Tests.time && event.type != Tests.less) {
            list.shuffle();
          }
          finalList = list;
        }
      }

      /// If the listName is not empty, it means that the user wants to have
      /// a Blitz Test on a certain KanList defined in "listName"
      else {
        List<Word> list =
            await _wordRepository.getAllWordsFromList(event.practiceList!);
        list.shuffle();
        finalList = list;
      }

      final kanjiInTest = getIt<PreferencesService>()
              .readData(SharedKeys.numberOfKanjiInTest) ??
          KPSizes.numberOfKanjiInTest;
      List<Word> sortedList = finalList.sublist(
          0, finalList.length < kanjiInTest ? finalList.length : kanjiInTest);

      emit(LoadTestStateLoadedList(sortedList, event.mode));
    });
  }
}
