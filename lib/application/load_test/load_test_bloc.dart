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
    on<LoadTestEventIdle>((_, __) {});

    on<LoadTestEventLoadList>((event, emit) async {
      List<Word> finalList = [];

      /// Get all the list of all kanji and perform a 20 kanji random sublist
      if (event.practiceList == null) {
        /// If the type is Folder or Blitz with a specified folder, gather all
        /// words within the folder
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
        } else {
          /// Else, just get all Kanji
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