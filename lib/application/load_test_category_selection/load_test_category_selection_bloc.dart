import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';

part 'load_test_category_selection_event.dart';
part 'load_test_category_selection_state.dart';

@lazySingleton
class LoadTestCategorySelectionBloc extends Bloc<LoadTestCategorySelectionEvent,
    LoadTestCategorySelectionState> {
  final IWordRepository _wordRepository;
  final IFolderRepository _folderRepository;

  LoadTestCategorySelectionBloc(
    this._wordRepository,
    this._folderRepository,
  ) : super(LoadTestCategorySelectionStateIdle()) {
    on<LoadTestCategorySelectionEventLoadList>((event, emit) async {
      List<Word> list = [];
      if (event.folder == null) {
        list =
            await _wordRepository.getWordsBasedOnCategory(event.category.index);
      } else {
        list = await _folderRepository.getAllWordsOnListsOnFolder(
          [event.folder!],
          type: Tests.categories,
          category: event.category.index,
        );
      }
      list.shuffle();
      emit(LoadTestCategorySelectionStateLoadedList(list));
    });
  }
}
