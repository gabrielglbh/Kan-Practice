import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/test_data.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:sqflite/sqflite.dart';

class TestQueries {
  Database? _database;

  TestQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final TestQueries _instance = TestQueries._();

  /// Singleton instance of [TestQueries]
  static TestQueries get instance => _instance;

  /// Creates a [Test] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createTest(Test test) async {
    if (_database != null) {
      try {
        await _database?.insert(TestTableFields.testTable, test.toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Removes all tests from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeTests() async {
    if (_database != null) {
      try {
        await _database?.delete(TestTableFields.testTable);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Query to get all [Test] from the db using lazy loading. Each time, helper
  /// will get 10 tests. When user gets to the end of list, another 10 will be retrieved.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Test>> getTests(int offset,
      {int limit = LazyLoadingLimits.testHistory}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database
            ?.rawQuery("SELECT * FROM ${TestTableFields.testTable} "
                "ORDER BY ${TestTableFields.takenDateField} DESC ");
        //"LIMIT $limit OFFSET ${offset * limit}");
        if (res != null) {
          return List.generate(res.length, (i) => Test.fromJson(res![i]));
        } else {
          return [];
        }
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Query to get all [Test] from the db.
  Future<List<Test>> getAllTests() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(TestTableFields.testTable);
        if (res != null) {
          return List.generate(res.length, (i) => Test.fromJson(res![i]));
        } else {
          return [];
        }
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  Future<TestSpecificData> getSpecificTestData(Tests mode) async {
    if (_database != null) {
      try {
        final res = await _database?.query(
          TestSpecificDataTableFields.testDataTable,
          where: "${TestSpecificDataTableFields.idField}=?",
          whereArgs: [mode.index],
        );
        if (res != null) {
          return TestSpecificData.fromJson(res[0]);
        } else {
          return TestSpecificData.empty;
        }
      } catch (err) {
        print(err.toString());
        return TestSpecificData.empty;
      }
    } else {
      return TestSpecificData.empty;
    }
  }

  /// Get all stats from DB
  Future<TestData> getTestDataFromDb() async {
    if (_database != null) {
      try {
        final res = await _database?.query(
          TestDataTableFields.testDataTable,
          where: "${TestDataTableFields.statsIdField}=?",
          whereArgs: [TestDataTableFields.statsMainId],
        );
        if (res != null && res.isNotEmpty) {
          /// Populate all TestSpecificData
          TestData rawTestData = TestData.fromJson(res[0]);
          for (var t in Tests.values) {
            final rawSpec = await getSpecificTestData(t);
            if (rawSpec != TestSpecificData.empty) {
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
    } else {
      return TestData.empty;
    }
  }

  /// Update the stats when a test is finished
  Future<void> updateStats(Test test) async {
    if (_database != null) {
      try {
        final curr = await getTestDataFromDb();
        final totalTests = curr.totalTests + 1;

        final Map<String, num> map = {
          TestDataTableFields.totalTestsField: totalTests,
        };

        map.addEntries(_getAdditionalParams(curr, test).entries);
        map.addEntries(_getTestParams(curr, test).entries);

        await _updateSpecificTestStats(test);
        await _database?.update(
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

  /// Updates the initial map with the total writing tests, the total writing
  /// accuracy and the total tests accuracy using N*C + C' / N'
  Map<String, num> _getAdditionalParams(TestData curr, Test test) {
    final score = test.testScore;
    switch (StudyModesUtil.mapStudyMode(test.studyMode)) {
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

  /// Updates the count on test performed
  Map<String, num> _getTestParams(TestData curr, Test test) {
    switch (TestsUtils.mapTestMode(test.testMode!)) {
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

  /// Updates the [test] specific stats using N*C + C' / N'
  Future<void> _updateSpecificTestStats(Test test) async {
    final raw =
        await getSpecificTestData(TestsUtils.mapTestMode(test.testMode!));

    if (raw != TestSpecificData.empty) {
      late Map<String, num> map;

      switch (StudyModesUtil.mapStudyMode(test.studyMode)) {
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

      await _database?.update(
        TestSpecificDataTableFields.testDataTable,
        map,
        where: "${TestSpecificDataTableFields.idField}=?",
        whereArgs: [raw.id],
      );
    } else {
      final m = StudyModesUtil.mapStudyMode(test.studyMode);
      await _database?.insert(
        TestSpecificDataTableFields.testDataTable,
        TestSpecificData(
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
