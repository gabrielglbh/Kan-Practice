import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/alter_specific_data/alter_specific_data.dart';
import 'package:kanpractice/domain/alter_specific_data/i_alter_specific_data_repository.dart';
import 'package:kanpractice/domain/specific_data/i_specific_data_repository.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
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
  final IAlterSpecificDataRepository _alterSpecificDataRepository;

  TestDataRepositoryImpl(this._database, this._specificDataRepository,
      this._alterSpecificDataRepository);

  @override
  Map<String, num> getAdditionalParams(TestData curr, Test test) {
    final score = test.testScore;

    if (test.grammarMode != null) {
      switch (GrammarModes.values[test.grammarMode!]) {
        case GrammarModes.definition:
          final totalTests = curr.testTotalCountDefinition + 1;
          final newAcc = ((curr.testTotalCountDefinition *
                      curr.testTotalWinRateDefinition) +
                  score) /
              totalTests;
          return {
            TestDataTableFields.testTotalCountDefinitionField: totalTests,
            TestDataTableFields.testTotalWinRateDefinitionField: newAcc,
          };
        case GrammarModes.grammarPoints:
          final totalTests = curr.testTotalCountGrammarPoint + 1;
          final newAcc = ((curr.testTotalCountGrammarPoint *
                      curr.testTotalWinRateGrammarPoint) +
                  score) /
              totalTests;
          return {
            TestDataTableFields.testTotalCountGrammarPointField: totalTests,
            TestDataTableFields.testTotalWinRateGrammarPointField: newAcc,
          };
      }
    } else {
      switch (StudyModes.values[test.studyMode!]) {
        case StudyModes.writing:
          final totalTests = curr.testTotalCountWriting + 1;
          final newAcc =
              ((curr.testTotalCountWriting * curr.testTotalWinRateWriting) +
                      score) /
                  totalTests;
          return {
            TestDataTableFields.testTotalCountWritingField: totalTests,
            TestDataTableFields.testTotalWinRateWritingField: newAcc,
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
          };
      }
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
        // TODO: Adjust when other TEST like Numbers is added
        TestData rawTestData = TestData.fromJson(res[0]);
        for (var t in Tests.values) {
          if (t == Tests.numbers) {
            final rawAlterSpec =
                await _alterSpecificDataRepository.getAlterSpecificTestData(t);
            if (rawAlterSpec != AlterSpecificData.empty) {
              rawTestData = rawTestData.copyWith(alterTestSpecs: rawAlterSpec);
            }
          } else {
            final rawSpec =
                await _specificDataRepository.getSpecificTestData(t);
            if (rawSpec != SpecificData.empty) {
              rawTestData = rawTestData.copyWith(testSpecs: rawSpec);
            }
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
      case Tests.translation:
        return {
          TestDataTableFields.translationTestsField: curr.translationTests + 1
        };
    }
  }

  @override
  Future<void> insertExampleData() async {
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

      map.addEntries(getTestParams(curr, test).entries);

      // TODO: Adjust when other TEST like Numbers is added
      if (test.testMode == Tests.numbers.index) {
        await _alterSpecificDataRepository.updateAlterSpecificTestStats(test);
      } else {
        map.addEntries(getAdditionalParams(curr, test).entries);
        await _specificDataRepository.updateSpecificTestStats(test);
      }
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
