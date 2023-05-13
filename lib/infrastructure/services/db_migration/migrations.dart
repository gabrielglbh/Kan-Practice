import 'package:kanpractice/application/services/database_consts.dart';
import 'package:sqflite/sqflite.dart';

// TODO: Add new modes in the db migration
class Migrations {
  Future<void> version13to14(Database db) async {
    await db.rawQuery(
        "ALTER TABLE ${AlterTestSpecificDataTableFields.testDataTable} "
        "ADD COLUMN ${AlterTestSpecificDataTableFields.totalTranslationTestCountField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery(
        "ALTER TABLE ${AlterTestSpecificDataTableFields.testDataTable} "
        "ADD COLUMN ${AlterTestSpecificDataTableFields.totalWinRateTranslationTestField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.translationTestsField} INTEGER NOT NULL DEFAULT 0");

    await db.transaction((txn) async {
      await txn.execute("CREATE TABLE TEMP("
          "${TestDataTableFields.statsIdField} TEXT NOT NULL PRIMARY KEY, "
          "${TestDataTableFields.totalTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountWritingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountReadingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountRecognitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountListeningField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountSpeakingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountDefinitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateWritingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateReadingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateListeningField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateSpeakingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateDefinitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.selectionTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.blitzTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.remembranceTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.numberTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.lessPctTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.categoryTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.folderTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.dailyTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.translationTestsField} INTEGER NOT NULL DEFAULT 0)");
      await txn.execute("INSERT INTO "
          "TEMP(${TestDataTableFields.statsIdField}, "
          "${TestDataTableFields.totalTestsField}, "
          "${TestDataTableFields.testTotalCountWritingField}, "
          "${TestDataTableFields.testTotalCountReadingField}, "
          "${TestDataTableFields.testTotalCountRecognitionField}, "
          "${TestDataTableFields.testTotalCountListeningField}, "
          "${TestDataTableFields.testTotalCountSpeakingField}, "
          "${TestDataTableFields.testTotalCountDefinitionField}, "
          "${TestDataTableFields.testTotalCountGrammarPointField}, "
          "${TestDataTableFields.testTotalWinRateWritingField}, "
          "${TestDataTableFields.testTotalWinRateReadingField}, "
          "${TestDataTableFields.testTotalWinRateRecognitionField}, "
          "${TestDataTableFields.testTotalWinRateListeningField}, "
          "${TestDataTableFields.testTotalWinRateSpeakingField}, "
          "${TestDataTableFields.testTotalWinRateDefinitionField}, "
          "${TestDataTableFields.testTotalWinRateGrammarPointField}, "
          "${TestDataTableFields.selectionTestsField}, "
          "${TestDataTableFields.blitzTestsField}, "
          "${TestDataTableFields.remembranceTestsField}, "
          "${TestDataTableFields.numberTestsField}, "
          "${TestDataTableFields.lessPctTestsField}, "
          "${TestDataTableFields.categoryTestsField}, "
          "${TestDataTableFields.folderTestsField}, "
          "${TestDataTableFields.dailyTestsField}, "
          "${TestDataTableFields.translationTestsField}) "
          "SELECT "
          "${TestDataTableFields.statsIdField}, "
          "${TestDataTableFields.totalTestsField}, "
          "${TestDataTableFields.testTotalCountWritingField}, "
          "${TestDataTableFields.testTotalCountReadingField}, "
          "${TestDataTableFields.testTotalCountRecognitionField}, "
          "${TestDataTableFields.testTotalCountListeningField}, "
          "${TestDataTableFields.testTotalCountSpeakingField}, "
          "${TestDataTableFields.testTotalCountDefinitionField}, "
          "${TestDataTableFields.testTotalCountGrammarPointField}, "
          "${TestDataTableFields.testTotalWinRateWritingField}, "
          "${TestDataTableFields.testTotalWinRateReadingField}, "
          "${TestDataTableFields.testTotalWinRateRecognitionField}, "
          "${TestDataTableFields.testTotalWinRateListeningField}, "
          "${TestDataTableFields.testTotalWinRateSpeakingField}, "
          "${TestDataTableFields.testTotalWinRateDefinitionField}, "
          "${TestDataTableFields.testTotalWinRateGrammarPointField}, "
          "${TestDataTableFields.selectionTestsField}, "
          "${TestDataTableFields.blitzTestsField}, "
          "${TestDataTableFields.remembranceTestsField}, "
          "${TestDataTableFields.numberTestsField}, "
          "${TestDataTableFields.lessPctTestsField}, "
          "${TestDataTableFields.categoryTestsField}, "
          "${TestDataTableFields.folderTestsField}, "
          "${TestDataTableFields.dailyTestsField}, "
          "${TestDataTableFields.translationTestsField} "
          "FROM ${TestDataTableFields.testDataTable}");
      await txn.execute("DROP TABLE ${TestDataTableFields.testDataTable}");
      await txn.execute(
          "ALTER TABLE TEMP RENAME TO ${TestDataTableFields.testDataTable}");
    });
  }

  Future<void> version12to13(Database db) async {
    try {
      await db.execute(
          "CREATE TABLE ${AlterTestSpecificDataTableFields.testDataTable}("
          "${AlterTestSpecificDataTableFields.idField} INTEGER NOT NULL PRIMARY KEY DEFAULT -1, "
          "${AlterTestSpecificDataTableFields.totalNumberTestCountField} INTEGER NOT NULL DEFAULT 0, "
          "${AlterTestSpecificDataTableFields.totalWinRateNumberTestField} INTEGER NOT NULL DEFAULT 0)");
    } catch (err) {
      print(err);
    }
  }

  Future<void> version11to12(Database db) async {
    await db.rawQuery("ALTER TABLE ${ListTableFields.listsTable} "
        "ADD COLUMN ${ListTableFields.totalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");

    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.testTotalCountGrammarPointField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.testTotalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery(
        "ALTER TABLE ${TestSpecificDataTableFields.testDataTable} "
        "ADD COLUMN ${TestSpecificDataTableFields.totalGrammarPointCountField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery(
        "ALTER TABLE ${TestSpecificDataTableFields.testDataTable} "
        "ADD COLUMN ${TestSpecificDataTableFields.totalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery("ALTER TABLE ${GrammarTableFields.grammarTable} "
        "ADD COLUMN ${GrammarTableFields.winRateGrammarPointField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");
    await db.rawQuery("ALTER TABLE ${GrammarTableFields.grammarTable} "
        "ADD COLUMN ${GrammarTableFields.dateLastShownGrammarPointField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${GrammarTableFields.grammarTable} "
        "ADD COLUMN ${GrammarTableFields.repetitionsGrammarPointField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${GrammarTableFields.grammarTable} "
        "ADD COLUMN ${GrammarTableFields.previousEaseFactorGrammarPointField} INTEGER NOT NULL DEFAULT 2.5");
    await db.rawQuery("ALTER TABLE ${GrammarTableFields.grammarTable} "
        "ADD COLUMN ${GrammarTableFields.previousIntervalGrammarPointField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${GrammarTableFields.grammarTable} "
        "ADD COLUMN ${GrammarTableFields.previousIntervalAsDateGrammarPointField} INTEGER NOT NULL DEFAULT 0");

    await db.transaction((txn) async {
      await txn.execute("CREATE TABLE TEMP("
          "${TestDataTableFields.statsIdField} TEXT NOT NULL PRIMARY KEY, "
          "${TestDataTableFields.totalTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountWritingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountReadingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountRecognitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountListeningField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountSpeakingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountDefinitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalCountGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateWritingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateReadingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateListeningField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateSpeakingField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateDefinitionField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.testTotalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.selectionTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.blitzTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.remembranceTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.numberTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.lessPctTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.categoryTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.folderTestsField} INTEGER NOT NULL DEFAULT 0, "
          "${TestDataTableFields.dailyTestsField} INTEGER NOT NULL DEFAULT 0)");
      await txn.execute("INSERT INTO "
          "TEMP(${TestDataTableFields.statsIdField}, "
          "${TestDataTableFields.totalTestsField}, "
          "${TestDataTableFields.testTotalCountWritingField}, "
          "${TestDataTableFields.testTotalCountReadingField}, "
          "${TestDataTableFields.testTotalCountRecognitionField}, "
          "${TestDataTableFields.testTotalCountListeningField}, "
          "${TestDataTableFields.testTotalCountSpeakingField}, "
          "${TestDataTableFields.testTotalCountDefinitionField}, "
          "${TestDataTableFields.testTotalCountGrammarPointField}, "
          "${TestDataTableFields.testTotalWinRateWritingField}, "
          "${TestDataTableFields.testTotalWinRateReadingField}, "
          "${TestDataTableFields.testTotalWinRateRecognitionField}, "
          "${TestDataTableFields.testTotalWinRateListeningField}, "
          "${TestDataTableFields.testTotalWinRateSpeakingField}, "
          "${TestDataTableFields.testTotalWinRateDefinitionField}, "
          "${TestDataTableFields.testTotalWinRateGrammarPointField}, "
          "${TestDataTableFields.selectionTestsField}, "
          "${TestDataTableFields.blitzTestsField}, "
          "${TestDataTableFields.remembranceTestsField}, "
          "${TestDataTableFields.numberTestsField}, "
          "${TestDataTableFields.lessPctTestsField}, "
          "${TestDataTableFields.categoryTestsField}, "
          "${TestDataTableFields.folderTestsField}, "
          "${TestDataTableFields.dailyTestsField}) "
          "SELECT "
          "${TestDataTableFields.statsIdField}, "
          "${TestDataTableFields.totalTestsField}, "
          "${TestDataTableFields.testTotalCountWritingField}, "
          "${TestDataTableFields.testTotalCountReadingField}, "
          "${TestDataTableFields.testTotalCountRecognitionField}, "
          "${TestDataTableFields.testTotalCountListeningField}, "
          "${TestDataTableFields.testTotalCountSpeakingField}, "
          "${TestDataTableFields.testTotalCountDefinitionField}, "
          "${TestDataTableFields.testTotalCountGrammarPointField}, "
          "${TestDataTableFields.testTotalWinRateWritingField}, "
          "${TestDataTableFields.testTotalWinRateReadingField}, "
          "${TestDataTableFields.testTotalWinRateRecognitionField}, "
          "${TestDataTableFields.testTotalWinRateListeningField}, "
          "${TestDataTableFields.testTotalWinRateSpeakingField}, "
          "${TestDataTableFields.testTotalWinRateDefinitionField}, "
          "${TestDataTableFields.testTotalWinRateGrammarPointField}, "
          "${TestDataTableFields.selectionTestsField}, "
          "${TestDataTableFields.blitzTestsField}, "
          "${TestDataTableFields.remembranceTestsField}, "
          "${TestDataTableFields.numberTestsField}, "
          "${TestDataTableFields.lessPctTestsField}, "
          "${TestDataTableFields.categoryTestsField}, "
          "${TestDataTableFields.folderTestsField}, "
          "${TestDataTableFields.dailyTestsField} "
          "FROM ${TestDataTableFields.testDataTable}");
      await txn.execute("DROP TABLE ${TestDataTableFields.testDataTable}");
      await txn.execute(
          "ALTER TABLE TEMP RENAME TO ${TestDataTableFields.testDataTable}");
    });
  }

  Future<void> version10to11(Database db) async {
    await db.rawQuery("ALTER TABLE ${ListTableFields.listsTable} "
        "ADD COLUMN ${ListTableFields.totalWinRateDefinitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}");

    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.testTotalCountDefinitionField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery("ALTER TABLE ${TestDataTableFields.testDataTable} "
        "ADD COLUMN ${TestDataTableFields.testTotalWinRateDefinitionField} INTEGER NOT NULL DEFAULT 0");

    await db.rawQuery(
        "ALTER TABLE ${TestSpecificDataTableFields.testDataTable} "
        "ADD COLUMN ${TestSpecificDataTableFields.totalDefinitionCountField} INTEGER NOT NULL DEFAULT 0");
    await db.rawQuery(
        "ALTER TABLE ${TestSpecificDataTableFields.testDataTable} "
        "ADD COLUMN ${TestSpecificDataTableFields.totalWinRateDefinitionField} INTEGER NOT NULL DEFAULT 0");

    // BREAKING CHANGE: NOT NULL drop on studyMode
    await db.transaction((txn) async {
      await txn.execute("CREATE TABLE TEMP("
          "${TestTableFields.testIdField} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${TestTableFields.takenDateField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.testScoreField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.wordsInTestField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.wordsListsField} TEXT NOT NULL, "
          "${TestTableFields.studyModeField} INTEGER, "
          "${TestTableFields.testModeField} INTEGER NOT NULL DEFAULT -1)");
      await txn.execute("INSERT INTO "
          "TEMP(${TestTableFields.testIdField}, "
          "${TestTableFields.takenDateField}, "
          "${TestTableFields.testScoreField}, "
          "${TestTableFields.wordsInTestField}, "
          "${TestTableFields.wordsListsField}, "
          "${TestTableFields.studyModeField}, "
          "${TestTableFields.testModeField}) "
          "SELECT ${TestTableFields.testIdField}, "
          "${TestTableFields.takenDateField}, "
          "${TestTableFields.testScoreField}, "
          "${TestTableFields.wordsInTestField}, "
          "${TestTableFields.wordsListsField}, "
          "${TestTableFields.studyModeField}, "
          "${TestTableFields.testModeField} "
          "FROM ${TestTableFields.testTable}");
      await txn.execute("DROP TABLE ${TestTableFields.testTable}");
      await txn
          .execute("ALTER TABLE TEMP RENAME TO ${TestTableFields.testTable}");
      await txn.rawQuery("ALTER TABLE ${TestTableFields.testTable} "
          "ADD COLUMN ${TestTableFields.grammarModeField} INTEGER");
    });

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
