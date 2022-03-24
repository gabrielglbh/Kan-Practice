import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:sqflite/sqflite.dart';

class TestQueries {
  Database? _database;
  /// Singleton instance of [TestQueries]
  static TestQueries instance = TestQueries();

  TestQueries() { _database = CustomDatabase.instance.database; }

  /// Creates a [Test] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createTest(double score, int kanji, int mode, String lists) async {
    if (_database != null) {
      try {
        await _database?.insert(TestTableFields.testTable, Test(
          testScore: score, kanjiInTest: kanji,
          studyMode: mode,
          kanjiLists: lists,
          takenDate: GeneralUtils.getCurrentMilliseconds()).toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else return -2;
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
    } else return -2;
  }

  /// Query to get all [Test] from the db using lazy loading. Each time, helper
  /// will get 10 tests. When user gets to the end of list, another 10 will be retrieved.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Test>> getTests(int offset, {int limit = LazyLoadingLimits.testHistory}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery("SELECT * FROM ${TestTableFields.testTable} "
            "ORDER BY ${TestTableFields.takenDateField} DESC "
            "LIMIT $limit OFFSET ${offset * limit}");
        if (res != null) return List.generate(res.length, (i) => Test.fromJson(res![i]));
        else return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else return [];
  }

  /// Retrieves the total test count saved locally in the device.
  Future<int> getTotalTestCount() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(TestTableFields.testTable);
        if (res != null) return res.length;
        else return 0;
      } catch (err) {
        print(err.toString());
        return 0;
      }
    } else return -1;
  }

  /// Retrieves the total test accuracy saved locally in the device.
  Future<double> getTotalTestAccuracy() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(TestTableFields.testTable);
        if (res != null) {
          List<Test> l = List.generate(res.length, (i) => Test.fromJson(res![i]));
          double acc = 0;
          l.forEach((test) => acc += test.testScore);
          return acc / l.length;
        }
        else return 0;
      } catch (err) {
        print(err.toString());
        return 0;
      }
    } else return -1;
  }

  /// Retrieves the test count saved locally in the device based on the [StudyModes].
  Future<int> getTestCountBasedOnStudyMode(int mode) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(TestTableFields.testTable,
          where: "${TestTableFields.studyModeField}=?",
          whereArgs: [mode]
        );
        if (res != null) return res.length;
        else return 0;
      } catch (err) {
        print(err.toString());
        return 0;
      }
    } else return -1;
  }

  /// Retrieves the test accuracy saved locally in the device based on the [StudyModes].
  Future<double> getTestAccuracyBasedOnStudyMode(int mode) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(TestTableFields.testTable,
            where: "${TestTableFields.studyModeField}=?",
            whereArgs: [mode]
        );
        if (res != null) {
          List<Test> l = List.generate(res.length, (i) => Test.fromJson(res![i]));
          double acc = 0;
          l.forEach((test) => acc += test.testScore);
          return acc / l.length;
        }
        else return 0;
      } catch (err) {
        print(err.toString());
        return 0;
      }
    } else return -1;
  }
}