import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database/database_consts.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IWordRepository)
class WordRepositoryImpl implements IWordRepository {
  final Database _database;

  WordRepositoryImpl(this._database);

  @override
  Future<int> createWord(Word word) async {
    try {
      await _database.insert(WordTableFields.wordTable, word.toJson());
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<List<Word>> getAllWords({StudyModes? mode, Tests? type}) async {
    try {
      String query = "";
      if (type == Tests.time) {
        if (mode != null) {
          switch (mode) {
            case StudyModes.writing:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.dateLastShownWriting} ASC";
              break;
            case StudyModes.reading:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.dateLastShownReading} ASC";
              break;
            case StudyModes.recognition:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.dateLastShownRecognition} ASC";
              break;
            case StudyModes.listening:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.dateLastShownListening} ASC";
              break;
            case StudyModes.speaking:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.dateLastShownSpeaking} ASC";
              break;
          }
        } else {
          return [];
        }
      } else if (type == Tests.less) {
        if (mode != null) {
          switch (mode) {
            case StudyModes.writing:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.winRateWritingField} ASC";
              break;
            case StudyModes.reading:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.winRateReadingField} ASC";
              break;
            case StudyModes.recognition:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.winRateRecognitionField} ASC";
              break;
            case StudyModes.listening:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.winRateListeningField} ASC";
              break;
            case StudyModes.speaking:
              query = "SELECT * FROM ${WordTableFields.wordTable} "
                  "ORDER BY ${WordTableFields.winRateSpeakingField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else {
        query = "SELECT * FROM ${WordTableFields.wordTable}";
      }

      List<Map<String, dynamic>>? res = [];
      res = await _database.rawQuery(query);
      return List.generate(res.length, (i) => Word.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getAllWordsForPractice(
      String listName, StudyModes mode) async {
    try {
      List<Map<String, dynamic>>? res = [];
      switch (mode) {
        case StudyModes.writing:
          res = await _database.query(WordTableFields.wordTable,
              where: "${WordTableFields.listNameField}=?",
              whereArgs: [listName],
              orderBy: "${WordTableFields.winRateWritingField} ASC");
          break;
        case StudyModes.reading:
          res = await _database.query(WordTableFields.wordTable,
              where: "${WordTableFields.listNameField}=?",
              whereArgs: [listName],
              orderBy: "${WordTableFields.winRateReadingField} ASC");
          break;
        case StudyModes.recognition:
          res = await _database.query(WordTableFields.wordTable,
              where: "${WordTableFields.listNameField}=?",
              whereArgs: [listName],
              orderBy: "${WordTableFields.winRateRecognitionField} ASC");
          break;
        case StudyModes.listening:
          res = await _database.query(WordTableFields.wordTable,
              where: "${WordTableFields.listNameField}=?",
              whereArgs: [listName],
              orderBy: "${WordTableFields.winRateListeningField} ASC");
          break;
        case StudyModes.speaking:
          res = await _database.query(WordTableFields.wordTable,
              where: "${WordTableFields.listNameField}=?",
              whereArgs: [listName],
              orderBy: "${WordTableFields.winRateSpeakingField} ASC");
          break;
      }
      return List.generate(res.length, (i) => Word.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getAllWordsFromList(String listName,
      {int? offset, int? limit}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(WordTableFields.wordTable,
          where: "${WordTableFields.listNameField}=?",
          whereArgs: [listName],
          orderBy: "${WordTableFields.dateAddedField} ASC",
          limit: limit,
          offset: (offset != null && limit != null) ? (offset * limit) : null);
      return List.generate(res.length, (i) => Word.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getDailyWords(StudyModes mode) async {
    try {
      String query = "";
      switch (mode) {
        case StudyModes.writing:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "ORDER BY ${WordTableFields.dateLastShownWriting} ASC, "
              "${WordTableFields.winRateWritingField} ASC";
          break;
        case StudyModes.reading:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "ORDER BY ${WordTableFields.dateLastShownReading} ASC, "
              "${WordTableFields.winRateReadingField} ASC";
          break;
        case StudyModes.recognition:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "ORDER BY ${WordTableFields.dateLastShownRecognition} ASC, "
              "${WordTableFields.winRateRecognitionField} ASC";
          break;
        case StudyModes.listening:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "ORDER BY ${WordTableFields.dateLastShownListening} ASC, "
              "${WordTableFields.winRateListeningField} ASC";
          break;
        case StudyModes.speaking:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "ORDER BY ${WordTableFields.dateLastShownSpeaking} ASC, "
              "${WordTableFields.winRateSpeakingField} ASC";
          break;
      }
      final res = await _database.rawQuery(query);
      return List.generate(res.length, (i) => Word.fromJson(res[i]));
    } catch (e) {
      return [];
    }
  }

  @override
  Future<int> getTotalWordCount() async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(WordTableFields.wordTable);
      return res.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  @override
  Future<Word> getTotalWordsWinRates() async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(WordTableFields.wordTable);
      List<Word> l = List.generate(res.length, (i) => Word.fromJson(res![i]));
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
        listening += (kanji.winRateListening == DatabaseConstants.emptyWinRate
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
          word: '',
          winRateWriting: writing == 0 ? 0 : writing / total,
          winRateReading: reading == 0 ? 0 : reading / total,
          winRateRecognition: recognition == 0 ? 0 : recognition / total,
          winRateListening: listening == 0 ? 0 : listening / total,
          winRateSpeaking: speaking == 0 ? 0 : speaking / total);
    } catch (err) {
      print(err.toString());
      return Word.empty;
    }
  }

  @override
  Future<Word> getWord(String listName, String word) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(WordTableFields.wordTable,
          where:
              "${WordTableFields.listNameField}=? AND ${WordTableFields.wordField}=?",
          whereArgs: [listName, word]);
      return Word.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return Word.empty;
    }
  }

  @override
  Future<List<Word>> getWordsBasedOnCategory(int category) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(WordTableFields.wordTable,
          where: "${WordTableFields.categoryField}=?", whereArgs: [category]);
      return List.generate(res.length, (i) => Word.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getWordBasedOnSelectedLists(List<String> listNames) async {
    try {
      String whereClause = "";

      /// Build up the where clauses from the listName
      for (var x = 0; x < listNames.length; x++) {
        whereClause += "${WordTableFields.listNameField}=? OR ";
      }

      /// Clean up the String
      whereClause = whereClause.substring(0, whereClause.length - 4);
      List<Map<String, dynamic>>? res = [];

      res = await _database.query(WordTableFields.wordTable,
          where: whereClause, whereArgs: listNames);
      return List.generate(res.length, (i) => Word.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<int>> getWordsFromCategory() async {
    List<int> empty = List.generate(WordCategory.values.length, (index) => 0);
    try {
      List<int> count = [];
      for (int k = 0; k < WordCategory.values.length; k++) {
        List<Map<String, dynamic>>? res = await _database.query(
          WordTableFields.wordTable,
          where: "${WordTableFields.categoryField}=?",
          whereArgs: [WordCategory.values[k].index],
        );
        count.add(res.length);
      }
      return count;
    } catch (err) {
      print(err.toString());
      return empty;
    }
  }

  @override
  Future<List<Word>> getWordsMatchingQuery(String query, String listName,
      {required int offset, required int limit}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.rawQuery("SELECT * "
          "FROM ${WordTableFields.wordTable} "
          "WHERE ${WordTableFields.listNameField} = '$listName' "
          "AND (${WordTableFields.meaningField} LIKE '%$query%' "
          "OR ${WordTableFields.wordField} LIKE '%$query%' "
          "OR ${WordTableFields.pronunciationField} LIKE '%$query%') "
          "ORDER BY ${WordTableFields.dateAddedField} ASC "
          "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => Word.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<Batch?> mergeWords(Batch? batch, List<Word> words,
      ConflictAlgorithm conflictAlgorithm) async {
    for (var k in words) {
      batch?.insert(WordTableFields.wordTable, k.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    return batch;
  }

  @override
  Future<int> removeWord(String listName, String word) async {
    try {
      await _database.delete(WordTableFields.wordTable,
          where:
              "${WordTableFields.listNameField}=? AND ${WordTableFields.wordField}=?",
          whereArgs: [listName, word]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<int> updateWord(
      String listName, String word, Map<String, dynamic> fields) async {
    try {
      await _database.update(WordTableFields.wordTable, fields,
          where:
              "${WordTableFields.listNameField}=? AND ${WordTableFields.wordField}=?",
          whereArgs: [listName, word]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
