import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/types/wordlist_filters.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqflite.dart';

class ListQueries {
  Database? _database;

  ListQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final ListQueries _instance = ListQueries._();

  /// Singleton instance of [ListQueries]
  static ListQueries get instance => _instance;

  /// Creates a [WordList] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createList(String name) async {
    if (_database != null) {
      try {
        if (name.trim().isEmpty) return -1;
        await _database?.insert(
            KanListTableFields.listsTable,
            WordList(name: name, lastUpdated: Utils.getCurrentMilliseconds())
                .toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Query to get all [WordList] from the db with an optional [order] and [filter].
  /// If anything goes wrong, an empty list will be returned.
  Future<List<WordList>> getAllLists(
      {WordListFilters filter = WordListFilters.all,
      String order = "DESC",
      int? limit,
      int? offset}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanListTableFields.listsTable,
            orderBy: "${filter.filter} $order",
            limit: limit,
            offset: (offset != null && limit != null) ? offset * limit : null);
        if (res != null) {
          return List.generate(res.length, (i) => WordList.fromJson(res![i]));
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

  /// Query to get all [WordList] from the db to return the count.
  Future<int> getTotalListCount() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanListTableFields.listsTable);
        if (res != null) {
          return res.length;
        } else {
          return 0;
        }
      } catch (err) {
        print(err.toString());
        return 0;
      }
    } else {
      return -1;
    }
  }

  /// Query the [WordList] with the best scoring overall and the worst one.
  /// Returns the name of the list: FIRST -> best , SECOND -> worst
  Future<List<String>> getBestAndWorstList() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanListTableFields.listsTable);
        if (res != null) {
          final List<WordList> l =
              List.generate(res.length, (i) => WordList.fromJson(res![i]));
          List<String> listNames = [];
          List<double> listAcc = [];
          for (var list in l) {
            listNames.add(list.name);
            final double acc = list.totalWinRateWriting +
                list.totalWinRateReading +
                list.totalWinRateRecognition +
                list.totalWinRateListening;
            listAcc.add((acc <= 0 ? 0 : acc) / StudyModes.values.length);
          }
          final double best =
              listAcc.reduce((curr, next) => curr > next ? curr : next);
          final double worst =
              listAcc.reduce((curr, next) => curr < next ? curr : next);
          return [
            listNames[listAcc.indexOf(best)],
            listNames[listAcc.indexOf(worst)]
          ];
        } else {
          return ["", ""];
        }
      } catch (err) {
        print(err.toString());
        return ["", ""];
      }
    } else {
      return ["", ""];
    }
  }

  /// Query to get all [WordList] from the db based on a [query] that will match:
  /// list name, kanji, meaning and pronunciation.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<WordList>> getListsMatchingQuery(String query,
      {required int offset, required int limit}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery(
            "SELECT DISTINCT L.${KanListTableFields.nameField}, "
            "L.${KanListTableFields.totalWinRateWritingField}, "
            "L.${KanListTableFields.totalWinRateReadingField}, "
            "L.${KanListTableFields.totalWinRateRecognitionField}, "
            "L.${KanListTableFields.totalWinRateListeningField}, "
            "L.${KanListTableFields.totalWinRateSpeakingField}, "
            "L.${KanListTableFields.lastUpdatedField} "
            "FROM ${KanListTableFields.listsTable} L JOIN ${KanjiTableFields.kanjiTable} K "
            "ON K.${KanjiTableFields.listNameField}=L.${KanListTableFields.nameField} "
            "WHERE L.${KanListTableFields.nameField} LIKE '%$query%' OR K.${KanjiTableFields.meaningField} LIKE '%$query%' "
            "OR K.${KanjiTableFields.kanjiField} LIKE '%$query%' OR K.${KanjiTableFields.pronunciationField} LIKE '%$query%' "
            "ORDER BY ${KanListTableFields.lastUpdatedField} DESC "
            "LIMIT $limit OFFSET ${offset * limit}");
        if (res != null) {
          return List.generate(res.length, (i) => WordList.fromJson(res![i]));
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

  /// Query to get a [WordList] based on its [name].
  /// If anything goes wrong, a [WordList.empty] will be returned.
  Future<WordList> getList(String name) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanListTableFields.listsTable,
            where: "${KanjiTableFields.listNameField}=?", whereArgs: [name]);
        if (res != null) {
          return WordList.fromJson(res[0]);
        } else {
          return WordList.empty;
        }
      } catch (err) {
        print(err.toString());
        return WordList.empty;
      }
    } else {
      return WordList.empty;
    }
  }

  /// Gets a [WordList] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeList(String name) async {
    if (_database != null) {
      try {
        await _database?.delete(KanListTableFields.listsTable,
            where: "${KanjiTableFields.listNameField}=?", whereArgs: [name]);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Creates a [WordList] and updates it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateList(String name, Map<String, dynamic> fields) async {
    if (_database != null) {
      try {
        await _database?.update(KanListTableFields.listsTable, fields,
            where: "${KanjiTableFields.listNameField}=?", whereArgs: [name]);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }
}
