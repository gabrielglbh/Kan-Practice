import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:sqflite/sqflite.dart';

class Migrations {
  static batchUpdateDateLastShownBasedOnMode(Batch? batch, Kanji kanji) {
    int date = kanji.dateLastShown == 0 ? kanji.dateAdded : kanji.dateLastShown;
    batch?.update(KanjiTableFields.kanjiTable,
        { KanjiTableFields.dateLastShownWriting: date },
        where: "${KanjiTableFields.kanjiField}=?", whereArgs: [kanji.kanji],
        conflictAlgorithm: ConflictAlgorithm.replace);
    batch?.update(KanjiTableFields.kanjiTable,
        { KanjiTableFields.dateLastShownReading: date },
        where: "${KanjiTableFields.kanjiField}=?", whereArgs: [kanji.kanji],
        conflictAlgorithm: ConflictAlgorithm.replace);
    batch?.update(KanjiTableFields.kanjiTable,
        { KanjiTableFields.dateLastShownRecognition: date },
        where: "${KanjiTableFields.kanjiField}=?", whereArgs: [kanji.kanji],
        conflictAlgorithm: ConflictAlgorithm.replace);
    batch?.update(KanjiTableFields.kanjiTable,
        { KanjiTableFields.dateLastShownListening: date },
        where: "${KanjiTableFields.kanjiField}=?", whereArgs: [kanji.kanji],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> version3to4(Database db) async {
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

    /// If the user has already a database set up, fill all dateLastShown
    /// mode fields with dateAdded
    List<Map<String, dynamic>>? res = await db.query(KanjiTableFields.kanjiTable);
    if (res.isNotEmpty) {
      List<Kanji> kanji = List.generate(res.length, (i) => Kanji.fromJson(res[i]));
      final batch = db.batch();
      for (int x = 0; x < kanji.length; x++) {
        batchUpdateDateLastShownBasedOnMode(batch, kanji[x]);
      }
      await batch.commit();
    }
  }

  static Future<void> version2to3(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.winRateListeningField} INTEGER NOT NULL "
        "DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");
    await db.rawQuery("ALTER TABLE ${KanListTableFields.listsTable} "
        "ADD COLUMN ${KanListTableFields.totalWinRateListeningField} INTEGER NOT NULL "
        "DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");
  }

  static batchUpdateDateLastShown(Batch? batch, Kanji kanji) {
    batch?.update(KanjiTableFields.kanjiTable, {
      KanjiTableFields.dateLastShown: kanji.dateAdded
    }, where: "${KanjiTableFields.kanjiField}=?", whereArgs: [kanji.kanji],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> version1to2(Database db) async {
    await db.rawQuery("ALTER TABLE ${KanjiTableFields.kanjiTable} "
        "ADD COLUMN ${KanjiTableFields.dateLastShown} INTEGER NOT NULL DEFAULT 0");

    /// If the user has already a database set up, fill dateLastShown with dateAdded
    List<Map<String, dynamic>>? res = await db.query(KanjiTableFields.kanjiTable);
    if (res.isNotEmpty) {
      List<Kanji> kanji = List.generate(res.length, (i) => Kanji.fromJson(res[i]));
      final batch = db.batch();
      for (int x = 0; x < kanji.length; x++) {
        batchUpdateDateLastShown(batch, kanji[x]);
      }
      await batch.commit();
    }
  }
}