import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'load_test_folder_selection_event.dart';
part 'load_test_folder_selection_state.dart';

@lazySingleton
class LoadTestFolderSelectionBloc
    extends Bloc<LoadTestFolderSelectionEvent, LoadTestFolderSelectionState> {
  final IFolderRepository _folderRepository;

  LoadTestFolderSelectionBloc(this._folderRepository)
      : super(LoadTestFolderSelectionStateIdle()) {
    on<LoadTestFolderSelectionEventLoadList>((event, emit) async {
      List<Word> list =
          await _folderRepository.getAllWordsOnListsOnFolder(event.folders);
      list.shuffle();

      final kanjiInTest = getIt<PreferencesService>()
              .readData(SharedKeys.numberOfKanjiInTest) ??
          KPSizes.numberOfKanjiInTest;
      List<Word> sortedList = list.sublist(
          0, list.length < kanjiInTest ? list.length : kanjiInTest);

      emit(LoadTestFolderSelectionStateLoadedList(sortedList));
    });
  }
}
