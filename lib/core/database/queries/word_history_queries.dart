import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/word_history.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:sqflite/sqflite.dart';

class HistoryWordQueries {
  Database? _database;

  HistoryWordQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final HistoryWordQueries _instance = HistoryWordQueries._();

  /// Singleton instance of [HistoryWordQueries
  ///]
  static HistoryWordQueries get instance => _instance;

  /// Creates a [WordHistory] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createWord(String word) async {
    if (_database != null) {
      try {
        await _database?.insert(
            WordHistoryFields.historyTable,
            WordHistory(
              word: word,
              searchedOn: GeneralUtils.getCurrentMilliseconds(),
            ).toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Removes all history.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> removeAll() async {
    if (_database != null) {
      try {
        await _database?.delete(WordHistoryFields.historyTable);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Query to get all [WordHistory] from the db using lazy loading. Each time, helper
  /// will get 20 words. When user gets to the end of list, another 10 will be retrieved.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<WordHistory>> getHistory(int offset,
      {int limit = LazyLoadingLimits.wordHistory}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database
            ?.rawQuery("SELECT * FROM ${WordHistoryFields.historyTable} "
                "ORDER BY ${WordHistoryFields.searchedOnField} DESC "
                "LIMIT $limit OFFSET ${offset * limit}");
        if (res != null) {
          return List.generate(
              res.length, (i) => WordHistory.fromJson(res![i]));
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
}
