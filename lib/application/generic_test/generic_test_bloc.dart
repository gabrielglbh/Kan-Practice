import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'generic_test_event.dart';
part 'generic_test_state.dart';

part 'generic_test_bloc.freezed.dart';

@lazySingleton
class GenericTestBloc extends Bloc<GenericTestEvent, GenericTestState> {
  final IWordRepository _wordRepository;
  final IFolderRepository _folderRepository;
  final IPreferencesRepository _preferencesRepository;

  GenericTestBloc(
    this._wordRepository,
    this._folderRepository,
    this._preferencesRepository,
  ) : super(const GenericTestState.initial([])) {
    on<GenericTestEventIdle>((event, emit) async {
      if (event.mode == Tests.daily) {
        final wordsToReview =
            await _wordRepository.getSM2ReviewWordsAsForToday();
        emit(GenericTestState.initial(wordsToReview));
      } else {
        emit(const GenericTestState.initial([]));
      }
    });

    on<GenericTestEventLoadList>((event, emit) async {
      List<Word> finalList = [];

      if (event.practiceList == null) {
        if (event.type == Tests.folder ||
            (event.type == Tests.blitz && event.folder != null)) {
          final folders = event.folder == null
              ? event.selectionQuery ?? []
              : [event.folder!];
          finalList = await _folderRepository.getAllWordsOnListsOnFolder(
            folders,
          );
          finalList.shuffle();
        } else if ((event.type == Tests.time || event.type == Tests.less) &&
            event.folder != null) {
          finalList = await _folderRepository.getAllWordsOnListsOnFolder(
            [event.folder!],
            mode: event.mode,
            type: event.type,
          );
        } else if (event.type == Tests.daily) {
          finalList = await _wordRepository.getDailySM2Words(event.mode);
        } else if (event.type == Tests.lists) {
          finalList = await _wordRepository
              .getWordBasedOnSelectedLists(event.selectionQuery ?? []);
          finalList.shuffle();
        } else if (event.type == Tests.categories) {
          final selectedCategory = WordCategory.values
              .firstWhere((c) => c.name == event.selectionQuery?[0])
              .index;
          if (event.folder == null) {
            finalList =
                await _wordRepository.getWordsBasedOnCategory(selectedCategory);
          } else {
            finalList = await _folderRepository.getAllWordsOnListsOnFolder(
              [event.folder!],
              type: Tests.categories,
              category: selectedCategory,
            );
          }
          finalList.shuffle();
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

      final controlledPace =
          _preferencesRepository.readData(SharedKeys.dailyTestOnControlledPace);
      if (event.type == Tests.daily && controlledPace == true) {
        emit(GenericTestState.loaded(finalList, event.mode));
      } else {
        final wordsInTest =
            _preferencesRepository.readData(SharedKeys.numberOfWordInTest) ??
                KPSizes.numberOfWordInTest;

        List<Word> sortedList = finalList.sublist(
            0, finalList.length < wordsInTest ? finalList.length : wordsInTest);

        emit(GenericTestState.loaded(sortedList, event.mode));
      }
    });
  }
}
