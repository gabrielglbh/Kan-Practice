import 'package:kanpractice/application/services/database_consts.dart';
import 'package:sqflite/sqflite.dart';

class Migrations {
  Future<void> version10to11(Database db) async {
    await db.rawQuery("ALTER TABLE ${ListTableFields.listsTable} "
        "ADD COLUMN ${ListTableFields.totalWinRateDefinitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");

    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.testTotalCountDefinitionField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.testTotalWinRateDefinitionField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${TestTableFields.testTable} "
        "ADD COLUMN ${TestTableFields.grammarModeField} INTEGER NOT NULL DEFAULT 0");

    await db.execute("CREATE TABLE ${GrammarTableFields.grammarTable}("
        "${GrammarTableFields.nameField} TEXT NOT NULL, "
        "${GrammarTableFields.definitionField} TEXT NOT NULL, "
        "${GrammarTableFields.exampleField} TEXT NOT NULL, "
        "${GrammarTableFields.listNameField} TEXT NOT NULL, "
        "${GrammarTableFields.winRateDefinitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
        "${GrammarTableFields.dateAddedField} INTEGER NOT NULL DEFAULT 0, "
        "${GrammarTableFields.dateLastShownField} INTEGER NOT NULL DEFAULT 0, "
        "${GrammarTableFields.dateLastShownDefinitionField} INTEGER NOT NULL DEFAULT 0, "
        "${GrammarTableFields.repetitionsDefinitionField} INTEGER NOT NULL DEFAULT 0, "
        "${GrammarTableFields.previousEaseFactorDefinitionField} INTEGER NOT NULL DEFAULT 2.5, "
        "${GrammarTableFields.previousIntervalDefinitionField} INTEGER NOT NULL DEFAULT 0, "
        "${GrammarTableFields.previousIntervalAsDateDefinitionField} INTEGER NOT NULL DEFAULT 0, "
        "PRIMARY KEY (${GrammarTableFields.nameField}, ${GrammarTableFields.definitionField}), "
        "FOREIGN KEY (${GrammarTableFields.listNameField}) "
        "REFERENCES ${ListTableFields.listsTable}(${ListTableFields.nameField}) "
        "ON DELETE CASCADE ON UPDATE CASCADE)");
  }

  Future<void> version9to10(Database db) async {
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.repetitionsWritingField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousEaseFactorWritingField} INTEGER NOT NULL DEFAULT 2.5");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalWritingField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalAsDateWritingField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.repetitionsReadingField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousEaseFactorReadingField} INTEGER NOT NULL DEFAULT 2.5");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalReadingField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalAsDateReadingField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.repetitionsRecognitionField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousEaseFactorRecognitionField} INTEGER NOT NULL DEFAULT 2.5");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalRecognitionField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalAsDateRecognitionField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.repetitionsListeningField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousEaseFactorListeningField} INTEGER NOT NULL DEFAULT 2.5");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalListeningField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalAsDateListeningField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.repetitionsSpeakingField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousEaseFactorSpeakingField} INTEGER NOT NULL DEFAULT 2.5");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalSpeakingField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${WordTableFields.wordTable} "
        "ADD COLUMN ${WordTableFields.previousIntervalAsDateSpeakingField} INTEGER NOT NULL DEFAULT 0");
  }
}
