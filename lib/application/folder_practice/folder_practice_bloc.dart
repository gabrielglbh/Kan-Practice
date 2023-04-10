import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'folder_practice_event.dart';
part 'folder_practice_state.dart';

part 'folder_practice_bloc.freezed.dart';

@lazySingleton
class FolderPracticeBloc
    extends Bloc<FolderPracticeEvent, FolderPracticeState> {
  final IFolderRepository _folderRepository;
  final IPreferencesRepository _preferencesRepository;

  FolderPracticeBloc(this._folderRepository, this._preferencesRepository)
      : super(const FolderPracticeState.initial()) {
    on<FolderPracticeEventLoadList>((event, emit) async {
      List<Word> list =
          await _folderRepository.getAllWordsOnListsOnFolder([event.folder]);
      list.shuffle();

      final wordsInTest =
          _preferencesRepository.readData(SharedKeys.numberOfWordInTest) ??
              KPSizes.numberOfWordInTest;
      List<Word> sortedList = list.sublist(
          0, list.length < wordsInTest ? list.length : wordsInTest);

      emit(FolderPracticeState.loaded(sortedList, event.mode));
    });
  }
}
