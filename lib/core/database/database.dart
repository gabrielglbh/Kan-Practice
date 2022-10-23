import 'dart:io';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'migrations.dart';

class CustomDatabase {
  CustomDatabase._();

  static final CustomDatabase _instance = CustomDatabase._();

  /// Singleton instance of [CustomDatabase]
  static CustomDatabase get instance => _instance;

  /// Database to perform all the queries on
  static Database? _database;

  Database? get database => _database;

  /// Opens up the db and configures all of it
  Future<void> open() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "kanpractice.db");

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    _database = await openDatabase(
      path,
      version: 9,
      singleInstance: true,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await _onUpgrade(db, oldVersion, newVersion);
      },
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE ${WordTableFields.wordTable}("
            "${WordTableFields.wordField} TEXT NOT NULL, "
            "${WordTableFields.listNameField} TEXT NOT NULL, "
            "${WordTableFields.meaningField} TEXT NOT NULL, "
            "${WordTableFields.pronunciationField} TEXT NOT NULL, "
            "${WordTableFields.winRateWritingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${WordTableFields.winRateReadingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${WordTableFields.winRateRecognitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${WordTableFields.winRateListeningField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${WordTableFields.winRateSpeakingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${WordTableFields.dateAddedField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.dateLastShown} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.dateLastShownWriting} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.dateLastShownReading} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.dateLastShownRecognition} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.dateLastShownListening} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.dateLastShownSpeaking} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.categoryField} INTEGER NOT NULL DEFAULT 0, "
            "PRIMARY KEY (${WordTableFields.wordField}, ${WordTableFields.meaningField}, ${WordTableFields.pronunciationField}), "
            "FOREIGN KEY (${WordTableFields.listNameField}) "
            "REFERENCES ${ListTableFields.listsTable}(${ListTableFields.nameField}) "
            "ON DELETE CASCADE ON UPDATE CASCADE)");

        await db.execute("CREATE TABLE ${ListTableFields.listsTable}("
            "${ListTableFields.nameField} TEXT PRIMARY KEY NOT NULL, "
            "${ListTableFields.totalWinRateWritingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.totalWinRateReadingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.totalWinRateRecognitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.totalWinRateListeningField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.totalWinRateSpeakingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.lastUpdatedField} INTEGER NOT NULL DEFAULT 0)");

        await db.execute("CREATE TABLE ${TestTableFields.testTable}("
            "${TestTableFields.testIdField} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${TestTableFields.takenDateField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.testScoreField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.kanjiInTestField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.kanjiListsField} TEXT NOT NULL, "
            "${TestTableFields.studyModeField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.testModeField} INTEGER NOT NULL DEFAULT -1)");

        await db.execute("CREATE TABLE ${FolderTableFields.folderTable}("
            "${FolderTableFields.nameField} TEXT NOT NULL PRIMARY KEY, "
            "${FolderTableFields.lastUpdatedField} INTEGER NOT NULL DEFAULT 0)");

        await db.execute(
            "CREATE TABLE ${RelationFolderListTableFields.relTable}("
            "${RelationFolderListTableFields.nameField} TEXT NOT NULL, "
            "${RelationFolderListTableFields.listNameField} TEXT NOT NULL, "
            "PRIMARY KEY(${RelationFolderListTableFields.nameField}, ${RelationFolderListTableFields.listNameField}), "
            "FOREIGN KEY (${RelationFolderListTableFields.nameField}) REFERENCES ${FolderTableFields.folderTable}(${FolderTableFields.nameField}) ON DELETE CASCADE ON UPDATE CASCADE, "
            "FOREIGN KEY (${RelationFolderListTableFields.listNameField}) REFERENCES ${ListTableFields.listsTable}(${ListTableFields.nameField}) ON DELETE CASCADE ON UPDATE CASCADE)");

        await db.execute("CREATE TABLE ${WordHistoryFields.historyTable}("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${WordHistoryFields.wordField} TEXT NOT NULL, "
            "${WordHistoryFields.searchedOnField} INTEGER NOT NULL DEFAULT 0)");

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

        /// id is the [Test].index for future refers
        await db.execute(
            "CREATE TABLE ${TestSpecificDataTableFields.testDataTable}("
            "${TestSpecificDataTableFields.idField} INTEGER NOT NULL PRIMARY KEY DEFAULT -1, "
            "${TestSpecificDataTableFields.totalWritingCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalReadingCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalRecognitionCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalListeningCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalSpeakingCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateWritingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateReadingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateListeningField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateSpeakingField} INTEGER NOT NULL DEFAULT 0)");
      },
    );
  }

  /// Function to manage migrations on whenever an update is needed.
  /// Whenever the update to the DB, automatically put it on the onCreate DB
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final c = Migrations();
    if (oldVersion <= 1) c.version1to2(db);
    if (oldVersion <= 2) c.version2to3(db);
    if (oldVersion <= 3) c.version3to4(db);
    if (oldVersion <= 4) c.version4to5(db);
    if (oldVersion <= 5) c.version5to6(db);
    if (oldVersion <= 6) c.version6to7(db);
    if (oldVersion <= 7) c.version7to8(db);
    if (oldVersion <= 8) c.version8to9(db);
  }

  /// Closes up the current database.
  Future<void> close() async => await database?.close();
}
