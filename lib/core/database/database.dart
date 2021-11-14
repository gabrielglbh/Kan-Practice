import 'dart:io';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'migrations.dart';

class CustomDatabase {
  /// Singleton instance of [CustomDatabase]
  static CustomDatabase instance = CustomDatabase();

  /// Database to perform all the queries on
  Database? database;

  CustomDatabase() { open(); }

  /// Opens up the db and configures all of it
  Future<void> open() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "kanpractice.db");

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    database = await openDatabase(
      path,
      version: 1,
      singleInstance: true,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await _onUpgrade(db, oldVersion, newVersion);
      },
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE $kanjiTable("
            "$kanjiField TEXT PRIMARY KEY NOT NULL, "
            "$listNameField TEXT NOT NULL, "
            "$meaningField TEXT NOT NULL, "
            "$pronunciationField TEXT NOT NULL, "
            "$winRateWritingField INTEGER NOT NULL DEFAULT -1, "
            "$winRateReadingField INTEGER NOT NULL DEFAULT -1, "
            "$winRateRecognitionField INTEGER NOT NULL DEFAULT -1, "
            "$dateAddedField INTEGER NOT NULL DEFAULT 0, "
            "FOREIGN KEY ($listNameField) REFERENCES $listsTable($nameField) ON DELETE CASCADE ON UPDATE CASCADE)");

        await db.execute("CREATE TABLE $listsTable("
            "$nameField TEXT PRIMARY KEY NOT NULL, "
            "$totalWinRateWritingField INTEGER NOT NULL DEFAULT -1, "
            "$totalWinRateReadingField INTEGER NOT NULL DEFAULT -1, "
            "$totalWinRateRecognitionField INTEGER NOT NULL DEFAULT -1, "
            "$lastUpdatedField INTEGER NOT NULL DEFAULT 0)");

        await db.execute("CREATE TABLE $testTable("
            "$testIdField INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$takenDateField INTEGER NOT NULL DEFAULT 0, "
            "$testScoreField INTEGER NOT NULL DEFAULT 0, "
            "$kanjiInTestField INTEGER NOT NULL DEFAULT 0, "
            "$kanjiListsField TEXT NOT NULL, "
            "$studyModeField TEXT NOT NULL)");
      });
  }

  /// Function to manage migrations on whenever an update is needed.
  /// Whenever the update to the DB, automatically put it on the onCreate DB
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion <= 1) Migrations();
  }

  /// Closes up the current database.
  Future<void> close() async => await database?.close();
}