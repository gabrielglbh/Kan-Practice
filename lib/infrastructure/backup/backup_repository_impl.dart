import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/backup/backup.dart';
import 'package:kanpractice/domain/backup/i_backup_repository.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/specific_data/i_specific_data_repository.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IBackupRepository)
class BackupRepositoryImpl implements IBackupRepository {
  final FirebaseFirestore _ref;
  final FirebaseAuth _auth;
  final Database _database;
  final IWordRepository _wordRepository;
  final IGrammarPointRepository _grammarPointRepository;
  final IListRepository _listRepository;
  final IRelationFolderListRepository _relationFolderListRepository;
  final IFolderRepository _folderRepository;
  final ISpecificDataRepository _specificDataRepository;
  final ITestDataRepository _testDataRepository;

  BackupRepositoryImpl(
    this._auth,
    this._ref,
    this._database,
    this._wordRepository,
    this._grammarPointRepository,
    this._listRepository,
    this._relationFolderListRepository,
    this._folderRepository,
    this._specificDataRepository,
    this._testDataRepository,
  );

  final String collection = "BackUps";
  final String wordLabel = "Kanji";
  final String grammarLabel = "Grammar";
  final String listsLabel = "Lists";
  final String foldersLabel = "Folders";
  final String relFolderKanListLabel = "RelationsFK";
  final String testsLabel = "Tests";
  final String testSpecsLabel = "TestsSpecs";
  int writes = 0;

  /// We make sure that when the limit of 500 WRITES per batch is met,
  /// we commit the current batch and initialize it again to perform
  /// more operations.
  Future<WriteBatch> _reinitializeBatch(WriteBatch curr) async {
    if ((writes + 1) % 500 == 0) {
      await curr.commit();
      return _ref.batch();
    } else {
      return curr;
    }
  }

  @override
  Future<String> createBackUp() async {
    User? user = _auth.currentUser;
    await user?.reload();

    List<Word> word = await _wordRepository.getAllWords();
    List<GrammarPoint> grammar =
        await _grammarPointRepository.getAllGrammarPoints();
    List<WordList> lists = await _listRepository.getAllLists();
    TestData testData = await _testDataRepository.getTestDataFromDb();
    List<SpecificData> testSpecData = [];

    /// Remove from the back up the empty specs
    if (testData.selectionTestData.id != -1) {
      testSpecData.add(testData.selectionTestData);
    }
    if (testData.blitzTestData.id != -1) {
      testSpecData.add(testData.blitzTestData);
    }
    if (testData.remembranceTestData.id != -1) {
      testSpecData.add(testData.remembranceTestData);
    }
    if (testData.numberTestData.id != -1) {
      testSpecData.add(testData.numberTestData);
    }
    if (testData.lessPctTestData.id != -1) {
      testSpecData.add(testData.lessPctTestData);
    }
    if (testData.categoryTestData.id != -1) {
      testSpecData.add(testData.categoryTestData);
    }
    if (testData.folderTestData.id != -1) {
      testSpecData.add(testData.folderTestData);
    }
    if (testData.dailyTestData.id != -1) {
      testSpecData.add(testData.dailyTestData);
    }

    List<Folder> folders = await _folderRepository.getAllFolders();
    List<RelationFolderList> relFolderKanList =
        await _relationFolderListRepository.getFolderRelation();
    int date = Utils.getCurrentMilliseconds();

    if (lists.isEmpty) {
      return "backup_firebase_createBackUp_listEmpty".tr();
    } else {
      var batch = _ref.batch();
      try {
        /// Making sure the back up only contains the actual data of the device
        await removeBackUp();

        /// Word list
        for (int x = 0; x < word.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(wordLabel)
              .doc(word[x].word);
          batch.set(doc, word[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Grammar
        for (int x = 0; x < grammar.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(grammarLabel)
              .doc(grammar[x].name);
          batch.set(doc, grammar[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Lists
        for (int x = 0; x < lists.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(listsLabel)
              .doc(lists[x].name);
          batch.set(doc, lists[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Folders
        for (int x = 0; x < folders.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(foldersLabel)
              .doc(folders[x].folder);
          batch.set(doc, folders[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Tests
        final DocumentReference doc = _ref
            .collection(collection)
            .doc(user?.uid)
            .collection(testsLabel)
            .doc(testData.statsId.toString());
        batch.set(doc, testData.toJson());
        writes++;
        batch = await _reinitializeBatch(batch);

        /// Tests Specs
        for (int x = 0; x < testSpecData.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(testSpecsLabel)
              .doc(testSpecData[x].id.toString());
          batch.set(doc, testSpecData[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Relation Folder-KanList
        for (int x = 0; x < relFolderKanList.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(relFolderKanListLabel)
              .doc(x.toString());
          batch.set(doc, relFolderKanList[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Last updated
        batch.set(_ref.collection(collection).doc(user?.uid),
            {BackUp.updatedLabel: date});
        writes++;
        batch = await _reinitializeBatch(batch);

        await batch.commit();
        writes = 0;
        return "";
      } catch (e) {
        writes = 0;
        return e.toString();
      }
    }
  }

  @override
  Future<String> getLastUpdated(BuildContext context) async {
    User? user = _auth.currentUser;
    await user?.reload();

    try {
      final snapshot = await _ref.collection(collection).doc(user?.uid).get();
      if (snapshot.exists) {
        int date = snapshot.get("lastUpdated");
        return "${"backup_firebase_getLastUpdated_successful".tr()} "
            // ignore: use_build_context_synchronously
            "${Utils.parseDateMilliseconds(context, date)}";
      } else {
        return "backup_firebase_getLastUpdated_noBackUp".tr();
      }
    } catch (err) {
      return "backup_firebase_getLastUpdated_noBackUp".tr();
    }
  }

  @override
  Future<String> getVersion() async {
    try {
      final DocumentSnapshot ref =
          await _ref.collection("Versioning").doc("version").get();
      return await ref.get("version");
    } catch (err) {
      print(err.toString());
    }
    return "";
  }

  @override
  Future<List<String>> getVersionNotes(BuildContext context) async {
    List<String> notes = [];
    final locale = Localizations.localeOf(context).languageCode;
    try {
      final Future<DocumentSnapshot> ref =
          _ref.collection("Versioning").doc("version_notes").get();
      await ref.then((snapshot) {
        notes = snapshot.get(locale).cast<String>();
      });
    } catch (err) {
      notes = [];
    }
    return notes;
  }

  @override
  Future<String> removeBackUp() async {
    User? user = _auth.currentUser;
    await user?.reload();

    try {
      final wordSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(wordLabel)
          .get();
      final grammarSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(grammarLabel)
          .get();
      final listsSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(listsLabel)
          .get();
      final foldersSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(foldersLabel)
          .get();
      final testDataSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(testsLabel)
          .get();
      final testSpecDataSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(testSpecsLabel)
          .get();
      final relFolderKanListSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(relFolderKanListLabel)
          .get();

      var batch = _ref.batch();

      if (wordSnapshot.size > 0) {
        for (int x = 0; x < wordSnapshot.size; x++) {
          batch.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(wordLabel)
              .doc(Word.fromJson(wordSnapshot.docs[x].data()).word));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
      }

      if (grammarSnapshot.size > 0) {
        for (int x = 0; x < grammarSnapshot.size; x++) {
          batch.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(grammarLabel)
              .doc(GrammarPoint.fromJson(grammarSnapshot.docs[x].data()).name));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
      }

      if (listsSnapshot.size > 0) {
        for (int x = 0; x < listsSnapshot.size; x++) {
          batch.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(listsLabel)
              .doc(WordList.fromJson(listsSnapshot.docs[x].data()).name));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
      }

      if (foldersSnapshot.size > 0) {
        for (int x = 0; x < foldersSnapshot.size; x++) {
          batch.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(foldersLabel)
              .doc(Folder.fromJson(foldersSnapshot.docs[x].data()).folder));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
      }

      if (testDataSnapshot.size > 0) {
        batch.delete(_ref
            .collection(collection)
            .doc(user?.uid)
            .collection(testsLabel)
            .doc(TestData.fromJson(testDataSnapshot.docs[0].data())
                .statsId
                .toString()));
        writes++;
        batch = await _reinitializeBatch(batch);
      }

      if (relFolderKanListSnapshot.size > 0) {
        for (int x = 0; x < relFolderKanListSnapshot.size; x++) {
          batch.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(relFolderKanListLabel)
              .doc(x.toString()));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
      }

      if (testSpecDataSnapshot.size > 0) {
        for (int x = 0; x < testSpecDataSnapshot.size; x++) {
          batch.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(testSpecsLabel)
              .doc(SpecificData.fromJson(testSpecDataSnapshot.docs[x].data())
                  .id
                  .toString()));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
      }

      batch.delete(_ref.collection(collection).doc(user?.uid));
      writes++;
      batch = await _reinitializeBatch(batch);

      await batch.commit();
      writes = 0;
      return "";
    } catch (err) {
      writes = 0;
      return err.toString();
    }
  }

  @override
  Future<String> restoreBackUp() async {
    User? user = _auth.currentUser;
    await user?.reload();

    try {
      final wordSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(wordLabel)
          .get();
      final grammarSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(grammarLabel)
          .get();
      final listsSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(listsLabel)
          .get();
      final foldersSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(foldersLabel)
          .get();
      final testDataSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(testsLabel)
          .get();
      final testSpecDataSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(testSpecsLabel)
          .get();
      final relFolderKanListSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(relFolderKanListLabel)
          .get();

      List<Word> backUpWords = [];
      List<GrammarPoint> backUpGrammar = [];
      List<WordList> backUpLists = [];
      List<Folder> backUpFolders = [];
      List<RelationFolderList> backUpRelationFolderList = [];
      TestData backUpTestData = TestData.empty;
      List<SpecificData> backUpTestSpecData = [];

      if (wordSnapshot.size > 0) {
        for (int x = 0; x < wordSnapshot.size; x++) {
          backUpWords.add(Word.fromJson(wordSnapshot.docs[x].data()));
        }
      }

      if (grammarSnapshot.size > 0) {
        for (int x = 0; x < grammarSnapshot.size; x++) {
          backUpGrammar
              .add(GrammarPoint.fromJson(grammarSnapshot.docs[x].data()));
        }
      }

      if (listsSnapshot.size > 0) {
        for (int x = 0; x < listsSnapshot.size; x++) {
          backUpLists.add(WordList.fromJson(listsSnapshot.docs[x].data()));
        }
      }

      if (foldersSnapshot.size > 0) {
        for (int x = 0; x < foldersSnapshot.size; x++) {
          backUpFolders.add(Folder.fromJson(foldersSnapshot.docs[x].data()));
        }
      }

      if (testDataSnapshot.size > 0) {
        // TODO: Breaking change on 4.1.0
        // with definition and grammar point fields being required not null
        Map<String, dynamic> json = testDataSnapshot.docs[0].data();
        if (!json
            .containsKey(TestDataTableFields.testTotalCountDefinitionField)) {
          json.addEntries([
            const MapEntry(TestDataTableFields.testTotalCountDefinitionField, 0)
          ]);
        }
        if (!json
            .containsKey(TestDataTableFields.testTotalWinRateDefinitionField)) {
          json.addEntries([
            const MapEntry(
                TestDataTableFields.testTotalWinRateDefinitionField, 0)
          ]);
        }
        if (!json
            .containsKey(TestDataTableFields.testTotalCountGrammarPointField)) {
          json.addEntries([
            const MapEntry(
                TestDataTableFields.testTotalCountGrammarPointField, 0)
          ]);
        }
        if (!json.containsKey(
            TestDataTableFields.testTotalWinRateGrammarPointField)) {
          json.addEntries([
            const MapEntry(
                TestDataTableFields.testTotalWinRateGrammarPointField, 0)
          ]);
        }
        backUpTestData = TestData.fromJson(json);
      }

      if (relFolderKanListSnapshot.size > 0) {
        for (int x = 0; x < relFolderKanListSnapshot.size; x++) {
          backUpRelationFolderList.add(RelationFolderList.fromJson(
              relFolderKanListSnapshot.docs[x].data()));
        }
      }

      if (testSpecDataSnapshot.size > 0) {
        // TODO: Breaking change on 4.1.0
        // with definition and grammar point fields being required not null
        for (int x = 0; x < testSpecDataSnapshot.size; x++) {
          Map<String, dynamic> json = testSpecDataSnapshot.docs[x].data();
          if (!json.containsKey(
              TestSpecificDataTableFields.totalDefinitionCountField)) {
            json.addEntries([
              const MapEntry(
                  TestSpecificDataTableFields.totalDefinitionCountField, 0)
            ]);
          }
          if (!json.containsKey(
              TestSpecificDataTableFields.totalWinRateDefinitionField)) {
            json.addEntries([
              const MapEntry(
                  TestSpecificDataTableFields.totalWinRateDefinitionField, 0)
            ]);
          }
          if (!json.containsKey(
              TestSpecificDataTableFields.totalGrammarPointCountField)) {
            json.addEntries([
              const MapEntry(
                  TestSpecificDataTableFields.totalGrammarPointCountField, 0)
            ]);
          }
          if (!json.containsKey(
              TestSpecificDataTableFields.totalWinRateGrammarPointField)) {
            json.addEntries([
              const MapEntry(
                  TestSpecificDataTableFields.totalWinRateGrammarPointField, 0)
            ]);
          }
          backUpTestSpecData.add(SpecificData.fromJson(json));
        }
      }

      /// Order matters as words and grammar points depends on lists.
      /// Conflict algorithm allows us to merge the data from back up with current one.
      Batch? batch = _database.batch();

      batch = _listRepository.mergeLists(
          batch, backUpLists, ConflictAlgorithm.replace);

      batch = _wordRepository.mergeWords(
          batch, backUpWords, ConflictAlgorithm.ignore);

      batch = _grammarPointRepository.mergeGrammarPoints(
          batch, backUpGrammar, ConflictAlgorithm.ignore);

      batch = _folderRepository.mergeFolders(
          batch, backUpFolders, ConflictAlgorithm.replace);

      batch = _testDataRepository.mergeTestData(
          batch, backUpTestData, ConflictAlgorithm.replace);

      batch = _relationFolderListRepository.mergeRelationFolderList(
          batch, backUpRelationFolderList, ConflictAlgorithm.replace);

      batch = _specificDataRepository.mergeSpecificData(
          batch, backUpTestSpecData, ConflictAlgorithm.replace);

      final results = await batch?.commit();
      return results?.isEmpty == true
          ? "backup_queries_mergeBackUp_failed".tr()
          : "";
    } catch (err) {
      return err.toString();
    }
  }
}
