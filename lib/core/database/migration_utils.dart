import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/test_data.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:sqflite/sqflite.dart';

class MigrationUtils {
  batchUpdateTestMode(Batch? batch, Test test) {
    int testMode = 0;
    if (test.kanjiLists == "Blitz") {
      testMode = 1;
    } else if (test.kanjiLists == "Recuerdo" ||
        test.kanjiLists == "Remembrance" ||
        test.kanjiLists == "Erinnerung") {
      testMode = 2;
    } else if (test.kanjiLists == "Números aleatorios" ||
        test.kanjiLists == "Random Numbers" ||
        test.kanjiLists == "Zufallszahlen") {
      testMode = 3;
    } else if (test.kanjiLists == "Menos %" ||
        test.kanjiLists == "Less %" ||
        test.kanjiLists == "Weniger %") {
      testMode = 4;
    } else if (test.kanjiLists.contains("Categoría: ", 0) ||
        test.kanjiLists.contains("Category: ", 0) ||
        test.kanjiLists.contains("Kategorie: ", 0)) {
      testMode = 5;
    }

    batch?.update(
        TestTableFields.testTable, {TestTableFields.testModeField: testMode},
        where: "${TestTableFields.takenDateField}=?",
        whereArgs: [test.takenDate],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  batchUpdateDateLastShown(Batch? batch, Kanji kanji) {
    batch?.update(KanjiTableFields.kanjiTable,
        {KanjiTableFields.dateLastShown: kanji.dateAdded},
        where: "${KanjiTableFields.kanjiField}=?",
        whereArgs: [kanji.kanji],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<TestData> getTestData(Database db) async {
    final int totalTests = await _getTotalTestCount(db);
    final double totalTestAccuracy = await _getTotalTestAccuracy(db);
    final int testTotalCountWriting =
        await _getTestCountBasedOnStudyMode(db, StudyModes.writing.index);
    final int testTotalCountReading =
        await _getTestCountBasedOnStudyMode(db, StudyModes.reading.index);
    final int testTotalCountRecognition =
        await _getTestCountBasedOnStudyMode(db, StudyModes.recognition.index);
    final int testTotalCountListening =
        await _getTestCountBasedOnStudyMode(db, StudyModes.listening.index);
    final int testTotalCountSpeaking =
        await _getTestCountBasedOnStudyMode(db, StudyModes.speaking.index);
    final double testTotalWinRateWriting =
        await _getTestAccuracyBasedOnStudyMode(db, StudyModes.writing.index);
    final double testTotalWinRateReading =
        await _getTestAccuracyBasedOnStudyMode(db, StudyModes.reading.index);
    final double testTotalWinRateRecognition =
        await _getTestAccuracyBasedOnStudyMode(
            db, StudyModes.recognition.index);
    final double testTotalWinRateListening =
        await _getTestAccuracyBasedOnStudyMode(db, StudyModes.listening.index);
    final double testTotalWinRateSpeaking =
        await _getTestAccuracyBasedOnStudyMode(db, StudyModes.speaking.index);
    final List<int> testModesCount = await _getAllTestsBasedOnTestMode(db);
    final selection =
        await _getTestSpecificStudyModeAccuracies(db, Tests.lists);
    final blitz = await _getTestSpecificStudyModeAccuracies(db, Tests.blitz);
    final time = await _getTestSpecificStudyModeAccuracies(db, Tests.time);
    final numbers =
        await _getTestSpecificStudyModeAccuracies(db, Tests.numbers);
    final less = await _getTestSpecificStudyModeAccuracies(db, Tests.less);
    final categories =
        await _getTestSpecificStudyModeAccuracies(db, Tests.categories);
    final folder = await _getTestSpecificStudyModeAccuracies(db, Tests.folder);
    final daily = await _getTestSpecificStudyModeAccuracies(db, Tests.daily);

    return TestData(
      totalTests: totalTests,
      totalTestAccuracy: totalTestAccuracy,
      testTotalCountWriting: testTotalCountWriting,
      testTotalCountReading: testTotalCountReading,
      testTotalCountRecognition: testTotalCountRecognition,
      testTotalCountListening: testTotalCountListening,
      testTotalCountSpeaking: testTotalCountSpeaking,
      testTotalWinRateWriting: testTotalWinRateWriting,
      testTotalWinRateReading: testTotalWinRateReading,
      testTotalWinRateRecognition: testTotalWinRateRecognition,
      testTotalWinRateListening: testTotalWinRateListening,
      testTotalWinRateSpeaking: testTotalWinRateSpeaking,
      selectionTests: testModesCount[0],
      selectionTestData: selection,
      blitzTests: testModesCount[1],
      blitzTestData: blitz,
      remembranceTests: testModesCount[2],
      remembranceTestData: time,
      numberTests: testModesCount[3],
      numberTestData: numbers,
      lessPctTests: testModesCount[4],
      lessPctTestData: less,
      categoryTests: testModesCount[5],
      categoryTestData: categories,
      folderTests: testModesCount[6],
      folderTestData: folder,
      dailyTests: testModesCount[7],
      dailyTestData: daily,
    );
  }

  /// Retrieves the total test count saved locally in the device.
  Future<int> _getTotalTestCount(Database db) async {
    try {
      final res = await db.query(TestTableFields.testTable);
      return res.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  /// Retrieves the total test accuracy saved locally in the device.
  Future<double> _getTotalTestAccuracy(Database db) async {
    try {
      final res = await db.query(TestTableFields.testTable);
      List<Test> l = List.generate(res.length, (i) => Test.fromJson(res[i]));
      double acc = 0;
      for (var test in l) {
        acc += test.testScore;
      }
      return acc / l.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  /// Retrieves the test count saved locally in the device based on the [StudyModes].
  Future<int> _getTestCountBasedOnStudyMode(Database db, int mode) async {
    try {
      final res = await db.query(TestTableFields.testTable,
          where: "${TestTableFields.studyModeField}=?", whereArgs: [mode]);
      return res.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  /// Retrieves the test accuracy saved locally in the device based on the [StudyModes].
  Future<double> _getTestAccuracyBasedOnStudyMode(Database db, int mode) async {
    try {
      final res = await db.query(TestTableFields.testTable,
          where: "${TestTableFields.studyModeField}=?", whereArgs: [mode]);
      List<Test> l = List.generate(res.length, (i) => Test.fromJson(res[i]));
      double acc = 0;
      for (var test in l) {
        acc += test.testScore;
      }
      return acc == 0 ? 0 : acc / l.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  /// Returns a list of counters of all the performed tests based on their test mode.
  /// See [TestsUtils]. Each position represents the number of tests performed
  /// in that mode.
  ///
  /// 0 -> Selection, 1 -> Blitz, 2 -> Remembrance, 3 -> Numbers, 4 -> Less %, 5 -> Category
  Future<List<int>> _getAllTestsBasedOnTestMode(Database db) async {
    List<int> counters = List.filled(Tests.values.length, 0);
    try {
      final res = await db.query(TestTableFields.testTable);
      final List<Test> tests =
          List.generate(res.length, (i) => Test.fromJson(res[i]));
      for (var t in tests) {
        switch (Tests.values[t.testMode ?? -1]) {
          case Tests.lists:
            counters[0] += 1;
            break;
          case Tests.blitz:
            counters[1] += 1;
            break;
          case Tests.time:
            counters[2] += 1;
            break;
          case Tests.numbers:
            counters[3] += 1;
            break;
          case Tests.less:
            counters[4] += 1;
            break;
          case Tests.categories:
            counters[5] += 1;
            break;
          case Tests.folder:
            counters[6] += 1;
            break;
          case Tests.daily:
            counters[7] += 1;
            break;
        }
      }
      return counters;
    } catch (err) {
      print(err.toString());
      return counters;
    }
  }

  Future<TestSpecificData> _getTestSpecificStudyModeAccuracies(
    Database db,
    Tests mode,
  ) async {
    try {
      final res = await db.query(TestTableFields.testTable,
          where: "${TestTableFields.testModeField}=?", whereArgs: [mode.index]);
      List<Test> t = List.generate(res.length, (i) => Test.fromJson(res[i]));
      if (t.isEmpty) return TestSpecificData.empty;

      double w = 0, red = 0, rec = 0, l = 0, s = 0;
      int wc = 0, redc = 0, recc = 0, lc = 0, sc = 0;

      for (var test in t) {
        switch (StudyModes.values[test.studyMode]) {
          case StudyModes.writing:
            w += test.testScore;
            wc += 1;
            break;
          case StudyModes.reading:
            red += test.testScore;
            redc += 1;
            break;
          case StudyModes.recognition:
            rec += test.testScore;
            recc += 1;
            break;
          case StudyModes.listening:
            l += test.testScore;
            lc += 1;
            break;
          case StudyModes.speaking:
            s += test.testScore;
            sc += 1;
            break;
        }
      }

      return TestSpecificData(
        id: mode.index,
        totalWritingCount: wc,
        totalReadingCount: redc,
        totalRecognitionCount: recc,
        totalListeningCount: lc,
        totalSpeakingCount: sc,
        totalWinRateWriting: wc == 0 ? 0 : w / wc,
        totalWinRateReading: redc == 0 ? 0 : red / redc,
        totalWinRateRecognition: recc == 0 ? 0 : rec / recc,
        totalWinRateListening: lc == 0 ? 0 : l / lc,
        totalWinRateSpeaking: sc == 0 ? 0 : s / sc,
      );
    } catch (err) {
      return TestSpecificData.empty;
    }
  }
}
