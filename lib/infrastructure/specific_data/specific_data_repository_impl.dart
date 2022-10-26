import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/domain/specific_data/i_specific_data_repository.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: ISpecificDataRepository)
class SpecificDataRepositoryImpl implements ISpecificDataRepository {
  static const categoryId = -9999;
  final Database _database;
  final IWordRepository _wordRepository;

  SpecificDataRepositoryImpl(this._database, this._wordRepository);

  @override
  Future<SpecificData> getSpecificCategoryData(WordCategory mode) async {
    try {
      final list = await _wordRepository.getWordsBasedOnCategory(mode.index);
      double writing = 0,
          reading = 0,
          recognition = 0,
          listening = 0,
          speaking = 0;
      for (var kanji in list) {
        writing += kanji.winRateWriting;
        reading += kanji.winRateReading;
        recognition += kanji.winRateRecognition;
        listening += kanji.winRateListening;
        speaking += kanji.winRateSpeaking;
      }
      return SpecificData(
        id: categoryId,
        totalWritingCount: list.length,
        totalReadingCount: 0,
        totalRecognitionCount: 0,
        totalListeningCount: 0,
        totalSpeakingCount: 0,
        totalWinRateWriting: writing / list.length,
        totalWinRateReading: reading / list.length,
        totalWinRateRecognition: recognition / list.length,
        totalWinRateListening: listening / list.length,
        totalWinRateSpeaking: speaking / list.length,
      );
    } catch (err) {
      print(err.toString());
      return SpecificData.empty;
    }
  }

  @override
  Future<SpecificData> getSpecificTestData(Tests mode) async {
    try {
      final res = await _database.query(
        TestSpecificDataTableFields.testDataTable,
        where: "${TestSpecificDataTableFields.idField}=?",
        whereArgs: [mode.index],
      );
      return SpecificData.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return SpecificData.empty;
    }
  }

  @override
  Future<Batch?> mergeSpecificData(
    Batch? batch,
    List<SpecificData> data,
    ConflictAlgorithm conflictAlgorithm,
  ) async {
    for (int x = 0; x < data.length; x++) {
      batch?.insert(TestSpecificDataTableFields.testDataTable, data[x].toJson(),
          conflictAlgorithm: conflictAlgorithm);
    }
    return batch;
  }

  @override
  Future<void> updateSpecificTestStats(Test test) async {
    final raw = await getSpecificTestData(Tests.values[test.testMode!]);

    if (raw != SpecificData.empty) {
      late Map<String, num> map;

      switch (StudyModes.values[test.studyMode]) {
        case StudyModes.writing:
          final count = raw.totalWritingCount + 1;
          map = {
            TestSpecificDataTableFields.totalWritingCountField: count,
            TestSpecificDataTableFields.totalWinRateWritingField:
                ((raw.totalWinRateWriting * raw.totalWritingCount) +
                        test.testScore) /
                    count
          };
          break;
        case StudyModes.reading:
          final count = raw.totalReadingCount + 1;
          map = {
            TestSpecificDataTableFields.totalReadingCountField: count,
            TestSpecificDataTableFields.totalWinRateReadingField:
                ((raw.totalWinRateReading * raw.totalReadingCount) +
                        test.testScore) /
                    count
          };
          break;
        case StudyModes.recognition:
          final count = raw.totalRecognitionCount + 1;
          map = {
            TestSpecificDataTableFields.totalRecognitionCountField: count,
            TestSpecificDataTableFields.totalWinRateRecognitionField:
                ((raw.totalWinRateRecognition * raw.totalRecognitionCount) +
                        test.testScore) /
                    count
          };
          break;
        case StudyModes.listening:
          final count = raw.totalListeningCount + 1;
          map = {
            TestSpecificDataTableFields.totalListeningCountField: count,
            TestSpecificDataTableFields.totalWinRateListeningField:
                ((raw.totalWinRateListening * raw.totalListeningCount) +
                        test.testScore) /
                    count
          };
          break;
        case StudyModes.speaking:
          final count = raw.totalSpeakingCount + 1;
          map = {
            TestSpecificDataTableFields.totalSpeakingCountField: count,
            TestSpecificDataTableFields.totalWinRateSpeakingField:
                ((raw.totalWinRateSpeaking * raw.totalSpeakingCount) +
                        test.testScore) /
                    count
          };
          break;
      }

      await _database.update(
        TestSpecificDataTableFields.testDataTable,
        map,
        where: "${TestSpecificDataTableFields.idField}=?",
        whereArgs: [raw.id],
      );
    } else {
      final m = StudyModes.values[test.studyMode];
      await _database.insert(
        TestSpecificDataTableFields.testDataTable,
        SpecificData(
          id: test.testMode!,
          totalWritingCount: m == StudyModes.writing ? 1 : 0,
          totalReadingCount: m == StudyModes.reading ? 1 : 0,
          totalRecognitionCount: m == StudyModes.recognition ? 1 : 0,
          totalListeningCount: m == StudyModes.listening ? 1 : 0,
          totalSpeakingCount: m == StudyModes.speaking ? 1 : 0,
          totalWinRateWriting: m == StudyModes.writing ? test.testScore : 0,
          totalWinRateReading: m == StudyModes.reading ? test.testScore : 0,
          totalWinRateRecognition:
              m == StudyModes.recognition ? test.testScore : 0,
          totalWinRateListening: m == StudyModes.listening ? test.testScore : 0,
          totalWinRateSpeaking: m == StudyModes.speaking ? test.testScore : 0,
        ).toJson(),
      );
    }
  }
}
