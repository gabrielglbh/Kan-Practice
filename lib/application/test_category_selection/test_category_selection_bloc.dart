import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';

part 'test_category_selection_event.dart';
part 'test_category_selection_state.dart';

@lazySingleton
class TestCategorySelectionBloc
    extends Bloc<TestCategorySelectionEvent, TestCategorySelectionState> {
  final IWordRepository _wordRepository;
  final IFolderRepository _folderRepository;

  TestCategorySelectionBloc(
    this._wordRepository,
    this._folderRepository,
  ) : super(TestCategorySelectionStateIdle()) {
    on<TestCategorySelectionEventIdle>((_, __) {});

    on<TestCategorySelectionEventLoadList>((event, emit) async {
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
      emit(TestCategorySelectionStateLoadedList(list));
    });
  }
}
