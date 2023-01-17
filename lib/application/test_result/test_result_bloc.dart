import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';
import 'package:kanpractice/domain/test_result/i_test_repository.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';

part 'test_result_event.dart';
part 'test_result_state.dart';

@lazySingleton
class TestResultBloc extends Bloc<TestResultEvent, TestResultState> {
  final ITestRepository _testRepository;
  final ITestDataRepository _testDataRepository;
  final IPreferencesRepository _preferencesRepository;

  TestResultBloc(
    this._testRepository,
    this._testDataRepository,
    this._preferencesRepository,
  ) : super(TestResultStateIdle()) {
    on<TestResultEventSaveTest>((event, emit) async {
      emit(TestResultStateSaving());
      await _testRepository.createTest(event.test);
      await _testDataRepository.updateStats(event.test);

      // TODO: Update timestamps on daily test only if needed on desired study mode
      final controlledPace =
          _preferencesRepository.readData(SharedKeys.dailyTestOnControlledPace);
      if (controlledPace == true && event.test.testMode == Tests.daily.index) {
        final now = DateTime.now();
        final nextMidnight =
            DateTime(now.year, now.month, now.day + 1).millisecondsSinceEpoch;

        if (event.test.studyMode == StudyModes.writing.index) {
          _preferencesRepository.saveData(
              SharedKeys.writingDailyPerformed, nextMidnight);
        }
        if (event.test.studyMode == StudyModes.reading.index) {
          _preferencesRepository.saveData(
              SharedKeys.readingDailyPerformed, nextMidnight);
        }
        if (event.test.studyMode == StudyModes.recognition.index) {
          _preferencesRepository.saveData(
              SharedKeys.recognitionDailyPerformed, nextMidnight);
        }
        if (event.test.studyMode == StudyModes.listening.index) {
          _preferencesRepository.saveData(
              SharedKeys.listeningDailyPerformed, nextMidnight);
        }
        if (event.test.studyMode == StudyModes.speaking.index) {
          _preferencesRepository.saveData(
              SharedKeys.speakingDailyPerformed, nextMidnight);
        }
        if (event.test.grammarMode == GrammarModes.definition.index) {
          _preferencesRepository.saveData(
              SharedKeys.definitionDailyPerformed, nextMidnight);
        }
        if (event.test.grammarMode == GrammarModes.grammarPoints.index) {
          _preferencesRepository.saveData(
              SharedKeys.grammarPointDailyPerformed, nextMidnight);
        }
      }
      emit(TestResultStateSaved());
    });
  }
}
