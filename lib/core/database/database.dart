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

    _database = await openDatabase(path, version: 6, singleInstance: true,
        onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await _onUpgrade(db, oldVersion, newVersion);
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ${KanjiTableFields.kanjiTable}("
          "${KanjiTableFields.kanjiField} TEXT NOT NULL, "
          "${KanjiTableFields.listNameField} TEXT NOT NULL, "
          "${KanjiTableFields.meaningField} TEXT NOT NULL, "
          "${KanjiTableFields.pronunciationField} TEXT NOT NULL, "
          "${KanjiTableFields.winRateWritingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanjiTableFields.winRateReadingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanjiTableFields.winRateRecognitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanjiTableFields.winRateListeningField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanjiTableFields.dateAddedField} INTEGER NOT NULL DEFAULT 0, "
          "${KanjiTableFields.dateLastShown} INTEGER NOT NULL DEFAULT 0, "
          "${KanjiTableFields.dateLastShownWriting} INTEGER NOT NULL DEFAULT 0, "
          "${KanjiTableFields.dateLastShownReading} INTEGER NOT NULL DEFAULT 0, "
          "${KanjiTableFields.dateLastShownRecognition} INTEGER NOT NULL DEFAULT 0, "
          "${KanjiTableFields.dateLastShownListening} INTEGER NOT NULL DEFAULT 0, "
          "${KanjiTableFields.categoryField} INTEGER NOT NULL DEFAULT 0, "
          "PRIMARY KEY (${KanjiTableFields.kanjiField}, ${KanjiTableFields.meaningField}, ${KanjiTableFields.pronunciationField}), "
          "FOREIGN KEY (${KanjiTableFields.listNameField}) "
          "REFERENCES ${KanListTableFields.listsTable}(${KanListTableFields.nameField}) "
          "ON DELETE CASCADE ON UPDATE CASCADE)");

      await db.execute("CREATE TABLE ${KanListTableFields.listsTable}("
          "${KanListTableFields.nameField} TEXT PRIMARY KEY NOT NULL, "
          "${KanListTableFields.totalWinRateWritingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanListTableFields.totalWinRateReadingField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanListTableFields.totalWinRateRecognitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanListTableFields.totalWinRateListeningField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
          "${KanListTableFields.lastUpdatedField} INTEGER NOT NULL DEFAULT 0)");

      await db.execute("CREATE TABLE ${TestTableFields.testTable}("
          "${TestTableFields.testIdField} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${TestTableFields.takenDateField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.testScoreField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.kanjiInTestField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.kanjiListsField} TEXT NOT NULL, "
          "${TestTableFields.studyModeField} INTEGER NOT NULL DEFAULT 0, "
          "${TestTableFields.testModeField} INTEGER NOT NULL DEFAULT -1)");
    });
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
  }

  /// Closes up the current database.
  Future<void> close() async => await database?.close();
}
