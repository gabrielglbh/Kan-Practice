import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/word_categories_filters.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IWordRepository)
class WordRepositoryImpl implements IWordRepository {
  final Database _database;
  final IPreferencesRepository _preferencesRepository;

  WordRepositoryImpl(this._database, this._preferencesRepository);

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
  Future<List<Word>> getArchiveWords(
      {WordCategoryFilter filter = WordCategoryFilter.all,
      String order = "DESC",
      int? offset,
      int? limit}) async {
    try {
      final isAll = filter == WordCategoryFilter.all;
      List<Map<String, dynamic>>? res = await _database.query(
          WordTableFields.wordTable,
          where: isAll ? null : "${WordTableFields.categoryField}=?",
          whereArgs: isAll ? null : [filter.filter],
          orderBy: "${WordTableFields.dateAddedField} $order",
          limit: limit,
          offset: (offset != null && limit != null) ? (offset * limit) : null);
      return List.generate(res.length, (i) => Word.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getAllWordsFromList(String listName,
      {int? offset, int? limit}) async {
    try {
      List<Map<String, dynamic>> res = await _database.query(
          WordTableFields.wordTable,
          where: "${WordTableFields.listNameField}=?",
          whereArgs: [listName],
          orderBy: "${WordTableFields.dateAddedField} ASC",
          limit: limit,
          offset: (offset != null && limit != null) ? (offset * limit) : null);
      return List.generate(res.length, (i) => Word.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getDailySM2Words(StudyModes mode) async {
    try {
      String query = "";
      String newestWordsQuery = "";
      final controlledPace =
          _preferencesRepository.readData(SharedKeys.dailyTestOnControlledPace);
      int limit =
          _preferencesRepository.readData(SharedKeys.numberOfWordInTest);

      if (controlledPace) {
        // Divide number of total words of the user's db by the weekdays
        limit = ((await _database.query(WordTableFields.wordTable)).length / 7)
            .ceil();

        // Also check if the daily test can be performed
        switch (mode) {
          case StudyModes.writing:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.writingDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
          case StudyModes.reading:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.readingDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
          case StudyModes.recognition:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.recognitionDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
          case StudyModes.listening:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.listeningDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
          case StudyModes.speaking:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.speakingDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
        }
      }

      // We order by previousIntervalAsDate DESC, as we want to prioratize
      // early previous reviews rather than older ones.
      //
      // If we have pending review A since the day before yesterday and
      // fresh review B from yesterday, in this way B will be prioritized
      // over A.
      final today = DateTime.now().millisecondsSinceEpoch;
      switch (mode) {
        case StudyModes.writing:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateWritingField} <= $today "
              "ORDER BY ${WordTableFields.previousIntervalAsDateWritingField} DESC, "
              "${WordTableFields.winRateWritingField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestWordsQuery = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateWritingField} == 0 "
              "ORDER BY ${WordTableFields.winRateWritingField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
        case StudyModes.reading:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateReadingField} <= $today "
              "ORDER BY ${WordTableFields.previousIntervalAsDateReadingField} DESC, "
              "${WordTableFields.winRateReadingField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestWordsQuery = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateReadingField} == 0 "
              "ORDER BY ${WordTableFields.winRateReadingField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
        case StudyModes.recognition:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateRecognitionField} <= $today "
              "ORDER BY ${WordTableFields.previousIntervalAsDateRecognitionField} DESC, "
              "${WordTableFields.winRateRecognitionField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestWordsQuery = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateRecognitionField} == 0 "
              "ORDER BY ${WordTableFields.winRateRecognitionField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
        case StudyModes.listening:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateListeningField} <= $today "
              "ORDER BY ${WordTableFields.previousIntervalAsDateListeningField} DESC, "
              "${WordTableFields.winRateListeningField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestWordsQuery = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateListeningField} == 0 "
              "ORDER BY ${WordTableFields.winRateListeningField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
        case StudyModes.speaking:
          query = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateSpeakingField} <= $today "
              "ORDER BY ${WordTableFields.previousIntervalAsDateSpeakingField} DESC, "
              "${WordTableFields.winRateSpeakingField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestWordsQuery = "SELECT * FROM ${WordTableFields.wordTable} "
              "WHERE ${WordTableFields.previousIntervalAsDateSpeakingField} == 0 "
              "ORDER BY ${WordTableFields.winRateSpeakingField} ASC, "
              "${WordTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
      }
      final res = await _database.rawQuery(query);
      final newestWords = await _database.rawQuery(newestWordsQuery);
      final list = List.generate(res.length, (i) => Word.fromJson(res[i]));
      final newestWordsList = List.generate(
          newestWords.length, (i) => Word.fromJson(newestWords[i]));
      newestWordsList.addAll(list);
      final setList = <Word>{};
      final finalList =
          newestWordsList.where((w) => setList.add(w)).take(limit).toList();
      return finalList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<int>> getSM2ReviewWordsAsForToday() async {
    try {
      final prefs = _preferencesRepository;
      final controlledPace =
          prefs.readData(SharedKeys.dailyTestOnControlledPace);
      List<String> limitQuery =
          List.generate(StudyModes.values.length, (_) => '');
      // Resets check on daily performed tests based on the ms on
      // the saved key and the next day's 00:00 ms.
      //
      // writingDailyPerformed stores the next day's 00:00 ms. If
      // now() ms is greater than writingDailyPerformed, it means that
      // the test is ready to be performed again --> thus saving 0ms.
      //
      // The value of writingDailyPerformed is updated in test_result_bloc.
      if (controlledPace) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final limit =
            ((await _database.query(WordTableFields.wordTable)).length / 7)
                .ceil();

        final w = prefs.readData(SharedKeys.writingDailyPerformed);
        if (w == null || (w != null && w <= now)) {
          prefs.saveData(SharedKeys.writingDailyPerformed, 0);
          limitQuery[0] = "LIMIT $limit";
        }
        final r = prefs.readData(SharedKeys.readingDailyPerformed);
        if (r == null || (r != null && r <= now)) {
          prefs.saveData(SharedKeys.readingDailyPerformed, 0);
          limitQuery[1] = "LIMIT $limit";
        }
        final rec = prefs.readData(SharedKeys.recognitionDailyPerformed);
        if (rec == null || (rec != null && rec <= now)) {
          prefs.saveData(SharedKeys.recognitionDailyPerformed, 0);
          limitQuery[2] = "LIMIT $limit";
        }
        final l = prefs.readData(SharedKeys.listeningDailyPerformed);
        if (l == null || (l != null && l <= now)) {
          prefs.saveData(SharedKeys.listeningDailyPerformed, 0);
          limitQuery[3] = "LIMIT $limit";
        }
        final s = prefs.readData(SharedKeys.speakingDailyPerformed);
        if (s == null || (s != null && s <= now)) {
          prefs.saveData(SharedKeys.speakingDailyPerformed, 0);
          limitQuery[4] = "LIMIT $limit";
        }
      }

      final writingNotification =
          prefs.readData(SharedKeys.writingDailyNotification);
      final readingNotification =
          prefs.readData(SharedKeys.readingDailyNotification);
      final recognitionNotification =
          prefs.readData(SharedKeys.recognitionDailyNotification);
      final listeningNotification =
          prefs.readData(SharedKeys.listeningDailyNotification);
      final speakingNotification =
          prefs.readData(SharedKeys.speakingDailyNotification);
      final today = DateTime.now().millisecondsSinceEpoch;

      final resWriting = writingNotification
          // If no limit has been set and we are in controlledPace mode
          // it means that there is no available tests for now.
          ? controlledPace && limitQuery[0].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${WordTableFields.wordField} FROM ${WordTableFields.wordTable} "
                  "WHERE ${WordTableFields.previousIntervalAsDateWritingField} <= $today "
                  "${limitQuery[0]}")
          : [];
      final resReading = readingNotification
          ? controlledPace && limitQuery[1].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${WordTableFields.wordField} FROM ${WordTableFields.wordTable} "
                  "WHERE ${WordTableFields.previousIntervalAsDateReadingField} <= $today "
                  "${limitQuery[1]}")
          : [];
      final resRecognition = recognitionNotification
          ? controlledPace && limitQuery[2].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${WordTableFields.wordField} FROM ${WordTableFields.wordTable} "
                  "WHERE ${WordTableFields.previousIntervalAsDateRecognitionField} <= $today "
                  "${limitQuery[2]}")
          : [];
      final resListening = listeningNotification
          ? controlledPace && limitQuery[3].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${WordTableFields.wordField} FROM ${WordTableFields.wordTable} "
                  "WHERE ${WordTableFields.previousIntervalAsDateListeningField} <= $today "
                  "${limitQuery[3]}")
          : [];
      final resSpeaking = speakingNotification
          ? controlledPace && limitQuery[4].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${WordTableFields.wordField} FROM ${WordTableFields.wordTable} "
                  "WHERE ${WordTableFields.previousIntervalAsDateSpeakingField} <= $today "
                  "${limitQuery[4]}")
          : [];
      return [
        resWriting.length,
        resReading.length,
        resRecognition.length,
        resListening.length,
        resSpeaking.length,
      ];
    } catch (err) {
      print(err.toString());
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
      for (var word in l) {
        writing += (word.winRateWriting == DatabaseConstants.emptyWinRate
            ? 0
            : word.winRateWriting);
        reading += (word.winRateReading == DatabaseConstants.emptyWinRate
            ? 0
            : word.winRateReading);
        recognition +=
            (word.winRateRecognition == DatabaseConstants.emptyWinRate
                ? 0
                : word.winRateRecognition);
        listening += (word.winRateListening == DatabaseConstants.emptyWinRate
            ? 0
            : word.winRateListening);
        speaking += (word.winRateSpeaking == DatabaseConstants.emptyWinRate
            ? 0
            : word.winRateSpeaking);
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
  Future<Word> getWord(String word, {String? listName, String? meaning}) async {
    try {
      assert((listName != null && meaning == null) ||
          (listName == null && meaning != null));
      List<Map<String, dynamic>>? res = [];

      if (listName != null) {
        res = await _database.query(WordTableFields.wordTable,
            where:
                "${WordTableFields.listNameField}=? AND ${WordTableFields.wordField}=?",
            whereArgs: [listName, word]);
      } else if (meaning != null) {
        res = await _database.query(WordTableFields.wordTable,
            where:
                "${WordTableFields.meaningField}=? AND ${WordTableFields.wordField}=?",
            whereArgs: [meaning, word]);
      }

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
  Future<List<Word>> getWordsMatchingQuery(String query,
      {String? listName, required int offset, required int limit}) async {
    try {
      List<Map<String, dynamic>> res = [];
      String whereClause = "";

      if (listName != null) {
        whereClause =
            "WHERE ${WordTableFields.listNameField} = '$listName' AND ";
      } else {
        whereClause = "WHERE ";
      }
      res = await _database.rawQuery("SELECT * "
          "FROM ${WordTableFields.wordTable} "
          "$whereClause "
          "(${WordTableFields.meaningField} LIKE '%$query%' "
          "OR ${WordTableFields.wordField} LIKE '%$query%' "
          "OR ${WordTableFields.pronunciationField} LIKE '%$query%') "
          "ORDER BY ${WordTableFields.dateAddedField} DESC "
          "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => Word.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Batch? mergeWords(
      Batch? batch, List<Word> words, ConflictAlgorithm conflictAlgorithm) {
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
