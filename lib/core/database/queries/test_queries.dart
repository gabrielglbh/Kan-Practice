import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/test_data.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
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
                "ORDER BY ${TestTableFields.takenDateField} DESC "
                "LIMIT $limit OFFSET ${offset * limit}");
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

  /// Get all stats from DB
  Future<TestData> getTestDataFromDb() async {
    if (_database != null) {
      try {
        final res = await _database?.query(
          TestDataTableFields.testDataTable,
          where: "${TestDataTableFields.statsIdField}=?",
          whereArgs: [TestDataTableFields.statsMainId],
        );
        if (res != null) {
          return TestData.fromJson(res[0]);
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
        final score = test.testScore;
        final Map<String, num> map = {
          TestDataTableFields.totalTestsField: totalTests,
        };
        late Map<String, num> additionalStudyParams;
        late Map<String, num> additionalTestParams;

        switch (StudyModesUtil.mapStudyMode(test.studyMode)) {
          case StudyModes.writing:
            final totalTests = curr.testTotalCountWriting + 1;
            final newAcc =
                ((curr.testTotalCountWriting * curr.testTotalWinRateWriting) +
                        score) /
                    totalTests;
            additionalStudyParams = {
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
            break;
          case StudyModes.reading:
            final totalTests = curr.testTotalCountReading + 1;
            final newAcc =
                ((curr.testTotalCountReading * curr.testTotalWinRateReading) +
                        score) /
                    totalTests;
            additionalStudyParams = {
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
            break;
          case StudyModes.recognition:
            final totalTests = curr.testTotalCountRecognition + 1;
            final newAcc = ((curr.testTotalCountRecognition *
                        curr.testTotalWinRateRecognition) +
                    score) /
                totalTests;
            additionalStudyParams = {
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
            break;
          case StudyModes.listening:
            final totalTests = curr.testTotalCountListening + 1;
            final newAcc = ((curr.testTotalCountListening *
                        curr.testTotalWinRateListening) +
                    score) /
                totalTests;
            additionalStudyParams = {
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
            break;
          case StudyModes.speaking:
            final totalTests = curr.testTotalCountSpeaking + 1;
            final newAcc =
                ((curr.testTotalCountSpeaking * curr.testTotalWinRateSpeaking) +
                        score) /
                    totalTests;
            additionalStudyParams = {
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
            break;
        }

        map.addEntries(additionalStudyParams.entries);

        switch (TestsUtils.mapTestMode(test.testMode!)) {
          case Tests.lists:
            additionalTestParams = {
              TestDataTableFields.selectionTestsField: curr.selectionTests + 1
            };
            break;
          case Tests.blitz:
            additionalTestParams = {
              TestDataTableFields.blitzTestsField: curr.blitzTests + 1
            };
            break;
          case Tests.time:
            additionalTestParams = {
              TestDataTableFields.remembranceTestsField:
                  curr.remembranceTests + 1
            };
            break;
          case Tests.numbers:
            additionalTestParams = {
              TestDataTableFields.numberTestsField: curr.numberTests + 1
            };
            break;
          case Tests.less:
            additionalTestParams = {
              TestDataTableFields.lessPctTestsField: curr.lessPctTests + 1
            };
            break;
          case Tests.categories:
            additionalTestParams = {
              TestDataTableFields.categoryTestsField: curr.categoryTests + 1
            };
            break;
          case Tests.folder:
            additionalTestParams = {
              TestDataTableFields.folderTestsField: curr.folderTests + 1
            };
            break;
          case Tests.daily:
            additionalTestParams = {
              TestDataTableFields.dailyTestsField: curr.dailyTests + 1
            };
            break;
        }

        map.addEntries(additionalTestParams.entries);

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
}
