import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/specific_data/i_specific_data_repository.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: ITestDataRepository)
class TestDataRepositoryImpl implements ITestDataRepository {
  final Database _database;
  final ISpecificDataRepository _specificDataRepository;

  TestDataRepositoryImpl(this._database, this._specificDataRepository);

  @override
  Map<String, num> getAdditionalParams(TestData curr, Test test) {
    final score = test.testScore;
    switch (StudyModes.values[test.studyMode]) {
      case StudyModes.writing:
        final totalTests = curr.testTotalCountWriting + 1;
        final newAcc =
            ((curr.testTotalCountWriting * curr.testTotalWinRateWriting) +
                    score) /
                totalTests;
        return {
          TestDataTableFields.testTotalCountWritingField: totalTests,
          TestDataTableFields.testTotalWinRateWritingField: newAcc,
          TestDataTableFields.totalTestAccuracyField:
              (curr.testTotalWinRateReading +
                      curr.testTotalWinRateRecognition +
                      curr.testTotalWinRateListening +
                      curr.testTotalWinRateSpeaking +
                      newAcc) /
                  StudyModes.values.length
        };
      case StudyModes.reading:
        final totalTests = curr.testTotalCountReading + 1;
        final newAcc =
            ((curr.testTotalCountReading * curr.testTotalWinRateReading) +
                    score) /
                totalTests;
        return {
          TestDataTableFields.testTotalCountReadingField: totalTests,
          TestDataTableFields.testTotalWinRateReadingField: newAcc,
          TestDataTableFields.totalTestAccuracyField:
              (curr.testTotalWinRateWriting +
                      curr.testTotalWinRateRecognition +
                      curr.testTotalWinRateListening +
                      curr.testTotalWinRateSpeaking +
                      newAcc) /
                  StudyModes.values.length
        };
      case StudyModes.recognition:
        final totalTests = curr.testTotalCountRecognition + 1;
        final newAcc = ((curr.testTotalCountRecognition *
                    curr.testTotalWinRateRecognition) +
                score) /
            totalTests;
        return {
          TestDataTableFields.testTotalCountRecognitionField: totalTests,
          TestDataTableFields.testTotalWinRateRecognitionField: newAcc,
          TestDataTableFields.totalTestAccuracyField:
              (curr.testTotalWinRateWriting +
                      curr.testTotalWinRateReading +
                      curr.testTotalWinRateListening +
                      curr.testTotalWinRateSpeaking +
                      newAcc) /
                  StudyModes.values.length
        };
      case StudyModes.listening:
        final totalTests = curr.testTotalCountListening + 1;
        final newAcc =
            ((curr.testTotalCountListening * curr.testTotalWinRateListening) +
                    score) /
                totalTests;
        return {
          TestDataTableFields.testTotalCountListeningField: totalTests,
          TestDataTableFields.testTotalWinRateListeningField: newAcc,
          TestDataTableFields.totalTestAccuracyField:
              (curr.testTotalWinRateWriting +
                      curr.testTotalWinRateReading +
                      curr.testTotalWinRateRecognition +
                      curr.testTotalWinRateSpeaking +
                      newAcc) /
                  StudyModes.values.length
        };
      case StudyModes.speaking:
        final totalTests = curr.testTotalCountSpeaking + 1;
        final newAcc =
            ((curr.testTotalCountSpeaking * curr.testTotalWinRateSpeaking) +
                    score) /
                totalTests;
        return {
          TestDataTableFields.testTotalCountSpeakingField: totalTests,
          TestDataTableFields.testTotalWinRateSpeakingField: newAcc,
          TestDataTableFields.totalTestAccuracyField:
              (curr.testTotalWinRateWriting +
                      curr.testTotalWinRateReading +
                      curr.testTotalWinRateRecognition +
                      curr.testTotalWinRateListening +
                      newAcc) /
                  StudyModes.values.length
        };
    }
  }

  @override
  Future<TestData> getTestDataFromDb() async {
    try {
      final res = await _database.query(
        TestDataTableFields.testDataTable,
        where: "${TestDataTableFields.statsIdField}=?",
        whereArgs: [TestDataTableFields.statsMainId],
      );
      if (res.isNotEmpty) {
        /// Populate all TestSpecificData
        TestData rawTestData = TestData.fromJson(res[0]);
        for (var t in Tests.values) {
          final rawSpec = await _specificDataRepository.getSpecificTestData(t);
          if (rawSpec != SpecificData.empty) {
            rawTestData = rawTestData.copyWith(rawSpec);
          }
        }
        return rawTestData;
      } else {
        return TestData.empty;
      }
    } catch (err) {
      print(err.toString());
      return TestData.empty;
    }
  }

  @override
  Map<String, num> getTestParams(TestData curr, Test test) {
    switch (Tests.values[test.testMode!]) {
      case Tests.lists:
        return {
          TestDataTableFields.selectionTestsField: curr.selectionTests + 1
        };
      case Tests.blitz:
        return {TestDataTableFields.blitzTestsField: curr.blitzTests + 1};
      case Tests.time:
        return {
          TestDataTableFields.remembranceTestsField: curr.remembranceTests + 1
        };
      case Tests.numbers:
        return {TestDataTableFields.numberTestsField: curr.numberTests + 1};
      case Tests.less:
        return {TestDataTableFields.lessPctTestsField: curr.lessPctTests + 1};
      case Tests.categories:
        return {TestDataTableFields.categoryTestsField: curr.categoryTests + 1};
      case Tests.folder:
        return {TestDataTableFields.folderTestsField: curr.folderTests + 1};
      case Tests.daily:
        return {TestDataTableFields.dailyTestsField: curr.dailyTests + 1};
    }
  }

  @override
  Future<void> insertInitialTestData() async {
    try {
      await _database.insert(
        TestDataTableFields.testDataTable,
        TestData.empty.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Batch? mergeTestData(
    Batch? batch,
    TestData data,
    ConflictAlgorithm conflictAlgorithm,
  ) {
    batch?.insert(TestDataTableFields.testDataTable, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return batch;
  }

  @override
  Future<void> updateStats(Test test) async {
    try {
      final curr = await getTestDataFromDb();
      final totalTests = curr.totalTests + 1;

      final Map<String, num> map = {
        TestDataTableFields.totalTestsField: totalTests,
      };

      map.addEntries(getAdditionalParams(curr, test).entries);
      map.addEntries(getTestParams(curr, test).entries);

      await _specificDataRepository.updateSpecificTestStats(test);
      await _database.update(
        TestDataTableFields.testDataTable,
        map,
        where: "${TestDataTableFields.statsIdField}=?",
        whereArgs: [TestDataTableFields.statsMainId],
      );
    } catch (err) {
      print(err.toString());
    }
  }
}
