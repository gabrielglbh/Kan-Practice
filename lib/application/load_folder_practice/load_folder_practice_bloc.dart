import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'load_folder_practice_event.dart';
part 'load_folder_practice_state.dart';

@lazySingleton
class LoadFolderPracticeBloc
    extends Bloc<LoadFolderPracticeEvent, LoadFolderPracticeState> {
  final IFolderRepository _folderRepository;
  final IPreferencesRepository _preferencesRepository;

  LoadFolderPracticeBloc(this._folderRepository, this._preferencesRepository)
      : super(LoadFolderPracticeStateIdle()) {
    on<LoadFolderPracticeEventLoadList>((event, emit) async {
      List<Word> list =
          await _folderRepository.getAllWordsOnListsOnFolder([event.folder]);
      list.shuffle();

      final kanjiInTest =
          _preferencesRepository.readData(SharedKeys.numberOfKanjiInTest) ??
              KPSizes.numberOfKanjiInTest;
      List<Word> sortedList = list.sublist(
          0, list.length < kanjiInTest ? list.length : kanjiInTest);

      emit(LoadFolderPracticeStateLoadedList(sortedList, event.mode));
    });
  }
}
