import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:sqflite/sqflite.dart';

class Migrations {
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