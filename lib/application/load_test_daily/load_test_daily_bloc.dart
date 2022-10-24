import 'dart:math';

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

part 'load_test_daily_event.dart';
part 'load_test_daily_state.dart';

@lazySingleton
class LoadTestDailyBloc extends Bloc<LoadTestDailyEvent, LoadTestDailyState> {
  final IWordRepository _wordRepository;
  final IFolderRepository _folderRepository;

  LoadTestDailyBloc(
    this._folderRepository,
    this._wordRepository,
  ) : super(LoadTestDailyStateIdle()) {
    on<LoadTestDailyEventLoadList>((event, emit) async {
      final randomStudyMode =
          StudyModes.values[Random().nextInt(StudyModes.values.length)];

      List<Word> list = [];
      if (event.folder == null) {
        list = await _wordRepository.getDailyWords(randomStudyMode);
      } else {
        list = await _folderRepository.getAllWordsOnListsOnFolder(
          [event.folder!],
          type: Tests.daily,
          mode: randomStudyMode,
        );
      }

      final kanjiInTest = getIt<PreferencesService>()
              .readData(SharedKeys.numberOfKanjiInTest) ??
          KPSizes.numberOfKanjiInTest;
      List<Word> sortedList = list.sublist(
          0, list.length < kanjiInTest ? list.length : kanjiInTest);

      emit(LoadTestDailyStateLoadedList(sortedList, randomStudyMode));
    });
  }
}
