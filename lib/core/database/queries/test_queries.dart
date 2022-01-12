import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
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
  Future<List<Test>> getTests(int offset, {int limit = 15}) async {
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
}