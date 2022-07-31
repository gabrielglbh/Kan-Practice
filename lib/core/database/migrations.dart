import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/migration_utils.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:sqflite/sqflite.dart';

class Migrations extends MigrationUtils {
  Future<void> version6to7(Database db) async {
    await db.rawQuery(
        "CREATE TABLE ${KanListFolderRelationTableFields.relTable}("
        "${KanListFolderRelationTableFields.relIdField} INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${KanListFolderRelationTableFields.nameField} TEXT NOT NULL, "
        "${KanListFolderRelationTableFields.kanListNameField} TEXT NOT NULL, "
        "FOREIGN KEY (${KanListFolderRelationTableFields.nameField}) REFERENCES ${FolderTableFields.folderTable}(${FolderTableFields.nameField}) ON DELETE CASCADE ON UPDATE CASCADE, "
        "FOREIGN KEY (${KanListFolderRelationTableFields.kanListNameField}) REFERENCES ${KanListTableFields.listsTable}(${KanListTableFields.nameField}) ON DELETE CASCADE ON UPDATE CASCADE)");

    await db.rawQuery("CREATE TABLE ${FolderTableFields.folderTable}("
        "${FolderTableFields.nameField} TEXT NOT NULL PRIMARY KEY, "
        "${FolderTableFields.lastUpdatedField} INTEGER NOT NULL DEFAULT 0)");
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
