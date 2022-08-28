import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/migration_utils.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:sqflite/sqflite.dart';

class Migrations extends MigrationUtils {
  Future<void> version8to9(Database db) async {
    await db.execute("CREATE TABLE ${TestDataTableFields.testDataTable}("
        "${TestDataTableFields.statsIdField} TEXT NOT NULL PRIMARY KEY, "
        "${TestDataTableFields.totalTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.totalTestAccuracyField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalCountWritingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalCountReadingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalCountRecognitionField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalCountListeningField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalCountSpeakingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalWinRateWritingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalWinRateReadingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalWinRateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalWinRateListeningField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.testTotalWinRateSpeakingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.selectionTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.blitzTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.remembranceTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.numberTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.lessPctTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.categoryTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.folderTestsField} INTEGER NOT NULL DEFAULT 0, "
        "${TestDataTableFields.dailyTestsField} INTEGER NOT NULL DEFAULT 0)");

    await db.execute(
        "CREATE TABLE ${TestSpecificDataTableFields.testDataTable}("
        "${TestSpecificDataTableFields.idField} INTEGER NOT NULL PRIMARY KEY DEFAULT -1, "
        "${TestSpecificDataTableFields.totalWinRateWritingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestSpecificDataTableFields.totalWinRateReadingField} INTEGER NOT NULL DEFAULT 0, "
        "${TestSpecificDataTableFields.totalWinRateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
        "${TestSpecificDataTableFields.totalWinRateListeningField} INTEGER NOT NULL DEFAULT 0, "
        "${TestSpecificDataTableFields.totalWinRateSpeakingField} INTEGER NOT NULL DEFAULT 0)");

    final currStats = await MigrationUtils().getTestData(db);

    try {
      await db.insert(TestDataTableFields.testDataTable, currStats.toJson());
      if (currStats.selectionTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.selectionTestData.toJson());
      }
      if (currStats.blitzTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.blitzTestData.toJson());
      }
      if (currStats.remembranceTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.remembranceTestData.toJson());
      }
      if (currStats.numberTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.numberTestData.toJson());
      }
      if (currStats.lessPctTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.lessPctTestData.toJson());
      }
      if (currStats.categoryTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.categoryTestData.toJson());
      }
      if (currStats.folderTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.folderTestData.toJson());
      }
      if (currStats.dailyTestData.id != -1) {
        await db.insert(TestSpecificDataTableFields.testDataTable,
            currStats.dailyTestData.toJson());
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> version7to8(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.winRateSpeakingField} INTEGER NOT NULL "
        "DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");

    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShownSpeaking} INTEGER NOT NULL "
        "DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${KanListTableFields.listsTable} "
        "ADD COLUMN ${KanListTableFields.totalWinRateSpeakingField} INTEGER NOT NULL "
        "DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");
  }

  Future<void> version6to7(Database db) async {
    await db.rawQuery(
        "CREATE TABLE ${KanListFolderRelationTableFields.relTable}("
        "${KanListFolderRelationTableFields.nameField} TEXT NOT NULL, "
        "${KanListFolderRelationTableFields.kanListNameField} TEXT NOT NULL, "
        "PRIMARY KEY(${KanListFolderRelationTableFields.nameField}, ${KanListFolderRelationTableFields.kanListNameField}), "
        "FOREIGN KEY (${KanListFolderRelationTableFields.nameField}) REFERENCES ${FolderTableFields.folderTable}(${FolderTableFields.nameField}) ON DELETE CASCADE ON UPDATE CASCADE, "
        "FOREIGN KEY (${KanListFolderRelationTableFields.kanListNameField}) REFERENCES ${KanListTableFields.listsTable}(${KanListTableFields.nameField}) ON DELETE CASCADE ON UPDATE CASCADE)");

    await db.rawQuery("CREATE TABLE ${FolderTableFields.folderTable}("
        "${FolderTableFields.nameField} TEXT NOT NULL PRIMARY KEY, "
        "${FolderTableFields.lastUpdatedField} INTEGER NOT NULL DEFAULT 0)");

    await db.execute("CREATE TABLE ${WordHistoryFields.historyTable}("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${WordHistoryFields.wordField} TEXT NOT NULL, "
        "${WordHistoryFields.searchedOnField} INTEGER NOT NULL DEFAULT 0)");
  }

  Future<void> version5to6(Database db) async {
    await db.rawQuery("ALTER TABLE ${TestTableFields.testTable} "
        "ADD COLUMN ${TestTableFields.testModeField} INTEGER NOT NULL "
        "DEFAULT -1");

    /// If the user has already a database set up, fill tests with correct TestMode
    List<Map<String, dynamic>>? res = await db.query(TestTableFields.testTable);
    if (res.isNotEmpty) {
      List<Test> tests =
          List.generate(res.length, (i) => Test.fromJson(res[i]));
      final batch = db.batch();
      for (int x = 0; x < tests.length; x++) {
        batchUpdateTestMode(batch, tests[x]);
      }
      await batch.commit();
    }
  }

  Future<void> version4to5(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.categoryField} INTEGER NOT NULL "
        "DEFAULT 0");
  }

  Future<void> version3to4(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShownWriting} INTEGER NOT NULL "
        "DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShownReading} INTEGER NOT NULL "
        "DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShownRecognition} INTEGER NOT NULL "
        "DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShownListening} INTEGER NOT NULL "
        "DEFAULT 0");
  }

  Future<void> version2to3(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.winRateListeningField} INTEGER NOT NULL "
        "DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");
    await db.rawQuery("ALTER TABLE ${KanListTableFields.listsTable} "
        "ADD COLUMN ${KanListTableFields.totalWinRateListeningField} INTEGER NOT NULL "
        "DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");
  }

  Future<void> version1to2(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShown} INTEGER NOT NULL DEFAULT 0");

    /// If the user has already a database set up, fill dateLastShown with dateAdded
    List<Map<String, dynamic>>? res =
        await db.query(KanjiTableFields.kanjiTable);
    if (res.isNotEmpty) {
      List<Kanji> kanji =
          List.generate(res.length, (i) => Kanji.fromJson(res[i]));
      final batch = db.batch();
      for (int x = 0; x < kanji.length; x++) {
        batchUpdateDateLastShown(batch, kanji[x]);
      }
      await batch.commit();
    }
  }
}
