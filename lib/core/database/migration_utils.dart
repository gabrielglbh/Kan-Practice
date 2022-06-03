import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
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
}
