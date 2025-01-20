import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/infrastructure/services/db_migration/migrations.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  @lazySingleton
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();
  @lazySingleton
  FlutterTts get tts => FlutterTts();
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // TODO: Add new modes in the db
  @preResolve
  Future<Database> get database async {
    late String databasesPath;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      databasesPath = "";
    } else {
      databasesPath = await getDatabasesPath();
    }
    String path = join(databasesPath, "kanpractice.db");

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    return await openDatabase(
      path,
      version: 16,
      singleInstance: true,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        final c = Migrations();
        if (oldVersion <= 9) c.version9to10(db);
        if (oldVersion <= 10) c.version10to11(db);
        if (oldVersion <= 11) c.version11to12(db);
        if (oldVersion <= 12) c.version12to13(db);
        if (oldVersion <= 13) c.version13to14(db);
        if (oldVersion <= 14) c.version14to15(db);
        if (oldVersion <= 15) c.version15to16(db);
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
            "${WordTableFields.repetitionsWritingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousEaseFactorWritingField} INTEGER NOT NULL DEFAULT 2.5, "
            "${WordTableFields.previousIntervalWritingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousIntervalAsDateWritingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.repetitionsReadingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousEaseFactorReadingField} INTEGER NOT NULL DEFAULT 2.5, "
            "${WordTableFields.previousIntervalReadingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousIntervalAsDateReadingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.repetitionsRecognitionField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousEaseFactorRecognitionField} INTEGER NOT NULL DEFAULT 2.5, "
            "${WordTableFields.previousIntervalRecognitionField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousIntervalAsDateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.repetitionsListeningField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousEaseFactorListeningField} INTEGER NOT NULL DEFAULT 2.5, "
            "${WordTableFields.previousIntervalListeningField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousIntervalAsDateListeningField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.repetitionsSpeakingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousEaseFactorSpeakingField} INTEGER NOT NULL DEFAULT 2.5, "
            "${WordTableFields.previousIntervalSpeakingField} INTEGER NOT NULL DEFAULT 0, "
            "${WordTableFields.previousIntervalAsDateSpeakingField} INTEGER NOT NULL DEFAULT 0, "
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
            "${ListTableFields.totalWinRateDefinitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.totalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${ListTableFields.lastUpdatedField} INTEGER NOT NULL DEFAULT 0)");

        await db.execute("CREATE TABLE ${TestTableFields.testTable}("
            "${TestTableFields.testIdField} INTEGER PRIMARY KEY AUTOINCREMENT, "
            "${TestTableFields.takenDateField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.testScoreField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.wordsInTestField} INTEGER NOT NULL DEFAULT 0, "
            "${TestTableFields.wordsListsField} TEXT NOT NULL, "
            "${TestTableFields.studyModeField} INTEGER, "
            "${TestTableFields.grammarModeField} INTEGER, "
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
            "${TestDataTableFields.testTotalSecondsPerWordWritingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestDataTableFields.testTotalSecondsPerWordReadingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestDataTableFields.testTotalSecondsPerWordRecognitionField} INTEGER NOT NULL DEFAULT 0, "
            "${TestDataTableFields.testTotalSecondsPerWordListeningField} INTEGER NOT NULL DEFAULT 0, "
            "${TestDataTableFields.testTotalSecondsPerWordSpeakingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestDataTableFields.testTotalSecondsPerPointGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
            "${TestDataTableFields.testTotalSecondsPerPointDefinitionField} INTEGER NOT NULL DEFAULT 0, "
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
            "${TestSpecificDataTableFields.totalDefinitionCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalGrammarPointCountField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateWritingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateReadingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateRecognitionField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateListeningField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateSpeakingField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateDefinitionField} INTEGER NOT NULL DEFAULT 0, "
            "${TestSpecificDataTableFields.totalWinRateGrammarPointField} INTEGER NOT NULL DEFAULT 0)");

        /// id is the [Test].index for future refers
        await db.execute(
            "CREATE TABLE ${AlterTestSpecificDataTableFields.testDataTable}("
            "${AlterTestSpecificDataTableFields.idField} INTEGER NOT NULL PRIMARY KEY DEFAULT -1, "
            "${AlterTestSpecificDataTableFields.totalNumberTestCountField} INTEGER NOT NULL DEFAULT 0, "
            "${AlterTestSpecificDataTableFields.totalWinRateNumberTestField} INTEGER NOT NULL DEFAULT 0)");

        await db.execute("CREATE TABLE ${GrammarTableFields.grammarTable}("
            "${GrammarTableFields.nameField} TEXT NOT NULL, "
            "${GrammarTableFields.definitionField} TEXT NOT NULL, "
            "${GrammarTableFields.exampleField} TEXT NOT NULL, "
            "${GrammarTableFields.listNameField} TEXT NOT NULL, "
            "${GrammarTableFields.winRateDefinitionField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${GrammarTableFields.winRateGrammarPointField} INTEGER NOT NULL DEFAULT ${DatabaseConstants.emptyWinRate.toString()}, "
            "${GrammarTableFields.dateAddedField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.dateLastShownField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.dateLastShownDefinitionField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.repetitionsDefinitionField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.previousEaseFactorDefinitionField} INTEGER NOT NULL DEFAULT 2.5, "
            "${GrammarTableFields.previousIntervalDefinitionField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.previousIntervalAsDateDefinitionField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.dateLastShownGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.repetitionsGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.previousEaseFactorGrammarPointField} INTEGER NOT NULL DEFAULT 2.5, "
            "${GrammarTableFields.previousIntervalGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
            "${GrammarTableFields.previousIntervalAsDateGrammarPointField} INTEGER NOT NULL DEFAULT 0, "
            "PRIMARY KEY (${GrammarTableFields.nameField}, ${GrammarTableFields.definitionField}), "
            "FOREIGN KEY (${GrammarTableFields.listNameField}) "
            "REFERENCES ${ListTableFields.listsTable}(${ListTableFields.nameField}) "
            "ON DELETE CASCADE ON UPDATE CASCADE)");
      },
    );
  }
}
