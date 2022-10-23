import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/types/word_categories.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:sqflite/sqflite.dart';

class WordQueries {
  Database? _database;

  WordQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final WordQueries _instance = WordQueries._();
  static const int categoryId = -9999;

  /// Singleton instance of [WordQueries]
  static WordQueries get instance => _instance;

  /// Creates a [Word] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createKanji(Word kanji) async {
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

  Future<List<Word>> getDailyKanjis(StudyModes mode) async {
    if (_database != null) {
      try {
        String query = "";
        switch (mode) {
          case StudyModes.writing:
            query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                "ORDER BY ${KanjiTableFields.dateLastShownWriting} ASC, "
                "${KanjiTableFields.winRateWritingField} ASC";
            break;
          case StudyModes.reading:
            query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                "ORDER BY ${KanjiTableFields.dateLastShownReading} ASC, "
                "${KanjiTableFields.winRateReadingField} ASC";
            break;
          case StudyModes.recognition:
            query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                "ORDER BY ${KanjiTableFields.dateLastShownRecognition} ASC, "
                "${KanjiTableFields.winRateRecognitionField} ASC";
            break;
          case StudyModes.listening:
            query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                "ORDER BY ${KanjiTableFields.dateLastShownListening} ASC, "
                "${KanjiTableFields.winRateListeningField} ASC";
            break;
          case StudyModes.speaking:
            query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                "ORDER BY ${KanjiTableFields.dateLastShownSpeaking} ASC, "
                "${KanjiTableFields.winRateSpeakingField} ASC";
            break;
        }
        final res = await _database?.rawQuery(query);
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res[i]));
        } else {
          return [];
        }
      } catch (e) {
        return [];
      }
    } else {
      return [];
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
  Future<List<Word>> getAllKanji({StudyModes? mode, Tests? type}) async {
    if (_database != null) {
      try {
        String query = "";
        if (type == Tests.time) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.dateLastShownWriting} ASC";
                break;
              case StudyModes.reading:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.dateLastShownReading} ASC";
                break;
              case StudyModes.recognition:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.dateLastShownRecognition} ASC";
                break;
              case StudyModes.listening:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.dateLastShownListening} ASC";
                break;
              case StudyModes.speaking:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.dateLastShownSpeaking} ASC";
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
                    "ORDER BY ${KanjiTableFields.winRateWritingField} ASC";
                break;
              case StudyModes.reading:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.winRateReadingField} ASC";
                break;
              case StudyModes.recognition:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.winRateRecognitionField} ASC";
                break;
              case StudyModes.listening:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.winRateListeningField} ASC";
                break;
              case StudyModes.speaking:
                query = "SELECT * FROM ${KanjiTableFields.kanjiTable} "
                    "ORDER BY ${KanjiTableFields.winRateSpeakingField} ASC";
                break;
            }
          } else {
            return [];
          }
        } else {
          query = "SELECT * FROM ${KanjiTableFields.kanjiTable}";
        }

        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery(query);
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res![i]));
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
  Future<List<Word>> getKanjiBasedOnSelectedLists(
      List<String> listNames) async {
    if (_database != null) {
      try {
        String whereClause = "";

        /// Build up the where clauses from the listName
        for (var x = 0; x < listNames.length; x++) {
          whereClause += "${KanjiTableFields.listNameField}=? OR ";
        }

        /// Clean up the String
        whereClause = whereClause.substring(0, whereClause.length - 4);
        List<Map<String, dynamic>>? res = [];

        res = await _database?.query(KanjiTableFields.kanjiTable,
            where: whereClause, whereArgs: listNames);
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res![i]));
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
  Future<List<Word>> getKanjiBasedOnCategory(int category) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable,
            where: "${KanjiTableFields.categoryField}=?",
            whereArgs: [category]);
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res![i]));
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

  Future<SpecificData> getSpecificCategoryData(WordCategory mode) async {
    if (_database != null) {
      try {
        final res = await _database?.query(
          KanjiTableFields.kanjiTable,
          where: "${KanjiTableFields.categoryField}=?",
          whereArgs: [mode.index],
        );
        if (res != null) {
          final list = List.generate(res.length, (i) => Word.fromJson(res[i]));
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
        } else {
          return SpecificData.empty;
        }
      } catch (err) {
        print(err.toString());
        return SpecificData.empty;
      }
    } else {
      return SpecificData.empty;
    }
  }

  /// Query to get all kanji available in the current db within a list with the name [listName].
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Word>> getAllKanjiFromList(String listName,
      {int? offset, int? limit}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable,
            where: "${KanjiTableFields.listNameField}=?",
            whereArgs: [listName],
            orderBy: "${KanjiTableFields.dateAddedField} ASC",
            limit: limit,
            offset:
                (offset != null && limit != null) ? (offset * limit) : null);
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res![i]));
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

  /// Query to get all [Word] from the db based on a [query] that will match:
  /// kanji, meaning and pronunciation.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Word>> getKanjiMatchingQuery(String query, String listName,
      {required int offset, required int limit}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery("SELECT * "
            "FROM ${KanjiTableFields.kanjiTable} "
            "WHERE ${KanjiTableFields.listNameField} = '$listName' "
            "AND (${KanjiTableFields.meaningField} LIKE '%$query%' "
            "OR ${KanjiTableFields.kanjiField} LIKE '%$query%' "
            "OR ${KanjiTableFields.pronunciationField} LIKE '%$query%') "
            "ORDER BY ${KanjiTableFields.dateAddedField} ASC "
            "LIMIT $limit OFFSET ${offset * limit}");
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res![i]));
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
  /// that enables Spatial Learning: ordering in ASC order the [Word] with less winRate.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Word>> getAllKanjiForPractice(
      String listName, StudyModes mode) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        switch (mode) {
          case StudyModes.writing:
            res = await _database?.query(KanjiTableFields.kanjiTable,
                where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName],
                orderBy: "${KanjiTableFields.winRateWritingField} ASC");
            break;
          case StudyModes.reading:
            res = await _database?.query(KanjiTableFields.kanjiTable,
                where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName],
                orderBy: "${KanjiTableFields.winRateReadingField} ASC");
            break;
          case StudyModes.recognition:
            res = await _database?.query(KanjiTableFields.kanjiTable,
                where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName],
                orderBy: "${KanjiTableFields.winRateRecognitionField} ASC");
            break;
          case StudyModes.listening:
            res = await _database?.query(KanjiTableFields.kanjiTable,
                where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName],
                orderBy: "${KanjiTableFields.winRateListeningField} ASC");
            break;
          case StudyModes.speaking:
            res = await _database?.query(KanjiTableFields.kanjiTable,
                where: "${KanjiTableFields.listNameField}=?",
                whereArgs: [listName],
                orderBy: "${KanjiTableFields.winRateSpeakingField} ASC");
            break;
        }
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res![i]));
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

  /// Query to get the count of [Word] on the whole database
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

  /// Query to get the total win rates of all [Word] on the whole database
  ///
  /// Returns an emptied [Word] with the sole purpose to store the values of
  /// the win rates
  Future<Word> getTotalKanjiWinRates() async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable);
        if (res != null) {
          List<Word> l =
              List.generate(res.length, (i) => Word.fromJson(res![i]));
          final int total = l.length;
          double writing = 0;
          double reading = 0;
          double recognition = 0;
          double listening = 0;
          double speaking = 0;
          for (var kanji in l) {
            writing += (kanji.winRateWriting == DatabaseConstants.emptyWinRate
                ? 0
                : kanji.winRateWriting);
            reading += (kanji.winRateReading == DatabaseConstants.emptyWinRate
                ? 0
                : kanji.winRateReading);
            recognition +=
                (kanji.winRateRecognition == DatabaseConstants.emptyWinRate
                    ? 0
                    : kanji.winRateRecognition);
            listening +=
                (kanji.winRateListening == DatabaseConstants.emptyWinRate
                    ? 0
                    : kanji.winRateListening);
            speaking += (kanji.winRateSpeaking == DatabaseConstants.emptyWinRate
                ? 0
                : kanji.winRateSpeaking);
          }
          return Word(
              meaning: '',
              pronunciation: '',
              listName: '',
              kanji: '',
              winRateWriting: writing == 0 ? 0 : writing / total,
              winRateReading: reading == 0 ? 0 : reading / total,
              winRateRecognition: recognition == 0 ? 0 : recognition / total,
              winRateListening: listening == 0 ? 0 : listening / total,
              winRateSpeaking: speaking == 0 ? 0 : speaking / total);
        } else {
          return Word.empty;
        }
      } catch (err) {
        print(err.toString());
        return Word.empty;
      }
    } else {
      return Word.empty;
    }
  }

  Future<List<int>> getKanjiFromCategory() async {
    List<int> empty = List.generate(WordCategory.values.length, (index) => 0);
    if (_database != null) {
      try {
        List<int> count = [];
        for (int k = 0; k < WordCategory.values.length; k++) {
          List<Map<String, dynamic>>? res = await _database?.query(
            KanjiTableFields.kanjiTable,
            where: "${KanjiTableFields.categoryField}=?",
            whereArgs: [WordCategory.values[k].index],
          );
          count.add(res != null ? res.length : 0);
        }
        return count;
      } catch (err) {
        print(err.toString());
        return empty;
      }
    } else {
      return empty;
    }
  }

  /// Query to get a [Word] based on a [listName] and its definition [Word].
  /// If anything goes wrong, a [Kanji.empty] will be returned.
  Future<Word> getKanji(String listName, String kanji) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(KanjiTableFields.kanjiTable,
            where:
                "${KanjiTableFields.listNameField}=? AND ${KanjiTableFields.kanjiField}=?",
            whereArgs: [listName, kanji]);
        if (res != null) {
          return Word.fromJson(res[0]);
        } else {
          return Word.empty;
        }
      } catch (err) {
        print(err.toString());
        return Word.empty;
      }
    } else {
      return Word.empty;
    }
  }

  /// Gets a [Word] and removes it from the db.
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
            where:
                "${KanjiTableFields.listNameField}=? AND ${KanjiTableFields.kanjiField}=?",
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

  /// Gets a [Word] and updates it on the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateKanji(
      String listName, String kanji, Map<String, dynamic> fields) async {
    if (_database != null) {
      try {
        await _database?.update(KanjiTableFields.kanjiTable, fields,
            where:
                "${KanjiTableFields.listNameField}=? AND ${KanjiTableFields.kanjiField}=?",
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
