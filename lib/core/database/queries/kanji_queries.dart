import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:sqflite/sqflite.dart';

class KanjiQueries {
  Database? _database;

  KanjiQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final KanjiQueries _instance = KanjiQueries._();

  /// Singleton instance of [KanjiQueries]
  static KanjiQueries get instance => _instance;

  /// Creates a [Kanji] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createKanji(Kanji kanji) async {
    if (_database != null) {
      try {
        await _database?.insert(KanjiTableFields.kanjiTable, kanji.toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Query to get all kanji available in the current db. If anything goes wrong,
  /// an empty list will be returned.
  ///
  /// [mode] is a nullable parameter that serves as a control variable to
  /// query all kanji by their last shown date based on the study mode to be
  /// studied. If null, all kanji will be retrieved.
  ///
  /// [type] serves as a control variable to order all the kanji by
  /// their last shown parameter or worst accuracy parameter. See [Tests].
  Future<List<Kanji>> getAllKanji({StudyModes? mode, Tests? type}) async {
    if (_database != null) {
      try {
        String query = "";
        if (type == Tests.time) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateWritingField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.dateLastShownWriting} ASC";
                break;
              case StudyModes.reading:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateReadingField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.dateLastShownReading} ASC";
                break;
              case StudyModes.recognition:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateRecognitionField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.dateLastShownRecognition} ASC";
                break;
              case StudyModes.listening:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateListeningField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.dateLastShownListening} ASC";
                break;
            }
          } else {
            return [];
          }
        } else if (type == Tests.less) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateWritingField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.winRateWritingField} ASC";
                break;
              case StudyModes.reading:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateReadingField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.winRateReadingField} ASC";
                break;
              case StudyModes.recognition:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateRecognitionField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.winRateRecognitionField} ASC";
                break;
              case StudyModes.listening:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateListeningField} != ${DatabaseConstants.emptyWinRate}"
                    "ORDER BY ${KanjiTableFields.winRateListeningField} ASC";
                break;
            }
          } else {
            return [];
          }
        } else if (type == Tests.blitz) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateWritingField} != ${DatabaseConstants.emptyWinRate}";
                break;
              case StudyModes.reading:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateReadingField} != ${DatabaseConstants.emptyWinRate}";
                break;
              case StudyModes.recognition:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateRecognitionField} != ${DatabaseConstants.emptyWinRate}";
                break;
              case StudyModes.listening:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "WHERE ${KanjiTableFields.winRateListeningField} != ${DatabaseConstants.emptyWinRate}";
                break;
            }
          } else {
            return [];
          }
        }
        else {
          query = "SELECT * FROM ${KanjiTableFields.kanjiTable}";
        }

        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery(query);
        if (res != null) {
          return List.generate(res.length, (i) => Kanji.fromJson(res![i]));
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

  /// Query to get all kanji available in the current db based on a chain of [listNames]
  /// that the user has previously selected.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Kanji>> getKanjiBasedOnSelectedLists(List<String> listNames) async {
    if (_database != null) {
      try {
        String whereClause = "";
        /// Build up the where clauses from the listName
        for (var _ in listNames) {
          whereClause += "${KanjiTableFields.listNameField}=? OR ";
        }
        /// Clean up the String
        whereClause = whereClause.substring(0, whereClause.length - 4);
        List<Map<String, dynamic>>? res = [];

        res = await _database?.query(KanjiTableFields.kanjiTable, where: whereClause, whereArgs: listNames);
        if (res != null) {
          return List.generate(res.length, (i) => Kanji.fromJson(res![i]));
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

  /// Query to get all kanji available in the current db based on their category
  /// that the user has previously selected.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Kanji>> getKanjiBasedOnCategory(int category) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable,
            where: "${KanjiTableFields.categoryField}=?", whereArgs: [category]);
        if (res != null) {
          return List.generate(res.length, (i) => Kanji.fromJson(res![i]));
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

  /// Query to get all kanji available in the current db within a list with the name [listName].
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Kanji>> getAllKanjiFromList(String listName, {int? offset, int? limit}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable,
          where: "${KanjiTableFields.listNameField}=?", whereArgs: [listName],
          orderBy: "${KanjiTableFields.dateAddedField} ASC",
          limit: limit,
          offset: (offset != null && limit != null) ? (offset * limit) : null
        );
        if (res != null) {
          return List.generate(res.length, (i) => Kanji.fromJson(res![i]));
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

  /// Query to get all [Kanji] from the db based on a [query] that will match:
  /// kanji, meaning and pronunciation.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Kanji>> getKanjiMatchingQuery(String query, String listName,
      {required int offset, required int limit}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery(
            "SELECT * "
                "FROM ${KanjiTableFields.kanjiTable} "
                "WHERE ${KanjiTableFields.listNameField} = '$listName' "
                "AND (${KanjiTableFields.meaningField} LIKE '%$query%' "
                "OR ${KanjiTableFields.kanjiField} LIKE '%$query%' "
                "OR ${KanjiTableFields.pronunciationField} LIKE '%$query%') "
                "ORDER BY ${KanjiTableFields.dateAddedField} ASC "
                "LIMIT $limit OFFSET ${offset * limit}"
        );
        if (res != null) {
          return List.generate(res.length, (i) => Kanji.fromJson(res![i]));
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

  /// Query to get all kanji available in the current db within a list with the name [listName]
  /// that enables Spatial Learning: ordering in ASC order the [Kanji] with less winRate.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Kanji>> getAllKanjiForPractice(String listName, StudyModes mode) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        switch (mode) {
          case StudyModes.writing:
            res = await _database?.query(KanjiTableFields.kanjiTable, where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName], orderBy: "${KanjiTableFields.winRateWritingField} ASC");
            break;
          case StudyModes.reading:
            res = await _database?.query(KanjiTableFields.kanjiTable, where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName], orderBy: "${KanjiTableFields.winRateReadingField} ASC");
            break;
          case StudyModes.recognition:
            res = await _database?.query(KanjiTableFields.kanjiTable, where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName], orderBy: "${KanjiTableFields.winRateRecognitionField} ASC");
            break;
          case StudyModes.listening:
            res = await _database?.query(KanjiTableFields.kanjiTable, where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName], orderBy: "${KanjiTableFields.winRateListeningField} ASC");
            break;
        }
        if (res != null) {
          return List.generate(res.length, (i) => Kanji.fromJson(res![i]));
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

  /// Query to get the count of [Kanji] on the whole database
  Future<int> getTotalKanjiCount() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable);
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

  /// Query to get the total win rates of all [Kanji] on the whole database
  ///
  /// Returns an emptied [Kanji] with the sole purpose to store the values of
  /// the win rates
  Future<Kanji> getTotalKanjiWinRates() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable);
        if (res != null) {
          List<Kanji> l = List.generate(res.length, (i) => Kanji.fromJson(res![i]));
          final int total = l.length;
          double writing = 0;
          double reading = 0;
          double recognition = 0;
          double listening = 0;
          for (var kanji in l) {
            writing += (kanji.winRateWriting == DatabaseConstants.emptyWinRate
                ? 0 : kanji.winRateWriting);
            reading += (kanji.winRateReading == DatabaseConstants.emptyWinRate
                ? 0 : kanji.winRateReading);
            recognition += (kanji.winRateRecognition == DatabaseConstants.emptyWinRate
                ? 0 : kanji.winRateRecognition);
            listening += (kanji.winRateListening == DatabaseConstants.emptyWinRate
                ? 0 : kanji.winRateListening);
          }
          return Kanji(
              meaning: '', pronunciation: '', listName: '', kanji: '',
              winRateWriting: writing == 0 ? 0 : writing / total,
              winRateReading: reading == 0 ? 0 : reading / total,
              winRateRecognition: recognition == 0 ? 0 : recognition / total,
              winRateListening: listening == 0 ? 0 : listening / total
          );
        }
        else {
          return Kanji.empty;
        }
      } catch (err) {
        print(err.toString());
        return Kanji.empty;
      }
    } else {
      return Kanji.empty;
    }
  }

  /// Query to get a [Kanji] based on a [listName] and its definition [kanji].
  /// If anything goes wrong, a [Kanji.empty] will be returned.
  Future<Kanji> getKanji(String listName, String kanji) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable,
            where: "${KanjiTableFields.listNameField}=? AND ${KanjiTableFields.kanjiField}=?",
            whereArgs: [listName, kanji]);
        if (res != null) {
          return Kanji.fromJson(res[0]);
        } else {
          return Kanji.empty;
        }
      } catch (err) {
        print(err.toString());
        return Kanji.empty;
      }
    } else {
      return Kanji.empty;
    }
  }

  /// Gets a [Kanji] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeKanji(String listName, String kanji) async {
    if (_database != null) {
      try {
        await _database?.delete(KanjiTableFields.kanjiTable,
            where: "${KanjiTableFields.listNameField}=? AND ${KanjiTableFields.kanjiField}=?",
            whereArgs: [listName, kanji]);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Gets a [Kanji] and updates it on the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateKanji(String listName, String kanji, Map<String, dynamic> fields) async {
    if (_database != null) {
      try {
        await _database?.update(KanjiTableFields.kanjiTable, fields,
            where: "${KanjiTableFields.listNameField}=? AND ${KanjiTableFields.kanjiField}=?",
            whereArgs: [listName, kanji]);
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