import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kanpractice/core/database/queries/back_up_queries.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/backup/backup.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class BackUpRecords {
  late FirebaseFirestore _ref;
  late FirebaseAuth _auth;
  final String collection = "BackUps";
  final String kanjiLabel = "Kanji";
  final String listsLabel = "Lists";
  final String foldersLabel = "Folders";
  final String relFolderKanListLabel = "RelationsFK";
  final String testsLabel = "Tests";
  final String testSpecsLabel = "TestsSpecs";

  BackUpRecords._() {
    _ref = FirebaseUtils.instance.dbRef;
    _auth = FirebaseUtils.instance.authRef;
  }

  static final BackUpRecords _instance = BackUpRecords._();

  /// Singleton instance of [BackUpRecords]
  static BackUpRecords get instance => _instance;

  /// We make sure that when the limit of 500 WRITES per batch is met,
  /// we commit the current batch and initialize it again to perform
  /// more operations.
  Future<WriteBatch?> _reinitializeBatch(WriteBatch? curr, int max) async {
    if ((max + 1) % 500 == 0) {
      await curr?.commit();
      return _ref.batch();
    } else {
      return curr;
    }
  }

  /// Gets the latest version of the app from Firebase to check against the current
  /// built version.
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

  /// Gets the version notes and changelogs of the current version.
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

  /// Creates the [BackUp] object and creates it in Firebase under the current UID.
  /// Based on sub collections.
  ///
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> createBackUp() async {
    User? user = _auth.currentUser;
    await user?.reload();

    List<Word> kanji = await WordQueries.instance.getAllKanji();
    List<WordList> lists = await ListQueries.instance.getAllLists();
    TestData testData = await TestQueries.instance.getTestDataFromDb();
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

    List<Folder> folders = await FolderQueries.instance.getAllFolders();
    List<RelationFolderList> relFolderKanList =
        await FolderQueries.instance.getFolderRelation();
    int date = Utils.getCurrentMilliseconds();

    if (lists.isEmpty) {
      return "backup_firebase_createBackUp_listEmpty".tr();
    } else {
      WriteBatch? batch = _ref.batch();
      try {
        /// Making sure the back up only contains the actual data of the device
        await removeBackUp();

        /// Kanji list
        for (int x = 0; x < kanji.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(kanjiLabel)
              .doc(kanji[x].word);
          batch?.set(doc, kanji[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Lists
        for (int x = 0; x < lists.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(listsLabel)
              .doc(lists[x].name);
          batch?.set(doc, lists[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Folders
        for (int x = 0; x < folders.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(foldersLabel)
              .doc(folders[x].folder);
          batch?.set(doc, folders[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Tests
        final DocumentReference doc = _ref
            .collection(collection)
            .doc(user?.uid)
            .collection(testsLabel)
            .doc(testData.statsId.toString());
        batch.set(doc, testData.toJson());

        await batch.commit();
        batch = _ref.batch();

        /// Tests Specs
        for (int x = 0; x < testSpecData.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(testSpecsLabel)
              .doc(testSpecData[x].id.toString());
          batch?.set(doc, testSpecData[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Relation Folder-KanList
        for (int x = 0; x < relFolderKanList.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(user?.uid)
              .collection(relFolderKanListLabel)
              .doc(x.toString());
          batch?.set(doc, relFolderKanList[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Last updated
        batch.set(_ref.collection(collection).doc(user?.uid),
            {BackUp.updatedLabel: date});

        await batch.commit();
        return "";
      } catch (e) {
        return e.toString();
      }
    }
  }

  /// Gets the [BackUp] object from Firebase and merges it with the actual data
  /// from the local db.
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> restoreBackUp() async {
    User? user = _auth.currentUser;
    await user?.reload();

    try {
      final kanjiSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(kanjiLabel)
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

      List<Word> backUpKanji = [];
      List<WordList> backUpLists = [];
      List<Folder> backUpFolders = [];
      List<RelationFolderList> backUpRelationFolderList = [];
      TestData backUpTestData = TestData.empty;
      List<SpecificData> backUpTestSpecData = [];

      if (kanjiSnapshot.size > 0 && listsSnapshot.size > 0) {
        for (int x = 0; x < kanjiSnapshot.size; x++) {
          backUpKanji.add(Word.fromJson(kanjiSnapshot.docs[x].data()));
        }
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
        backUpTestData = TestData.fromJson(testDataSnapshot.docs[0].data());
      }

      if (relFolderKanListSnapshot.size > 0) {
        for (int x = 0; x < relFolderKanListSnapshot.size; x++) {
          backUpRelationFolderList.add(RelationFolderList.fromJson(
              relFolderKanListSnapshot.docs[x].data()));
        }
      }

      if (testSpecDataSnapshot.size > 0) {
        for (int x = 0; x < testSpecDataSnapshot.size; x++) {
          backUpTestSpecData
              .add(SpecificData.fromJson(testSpecDataSnapshot.docs[x].data()));
        }
      }

      return await BackUpQueries.instance.mergeBackUp(BackUp(
        lists: backUpLists,
        words: backUpKanji,
        testData: backUpTestData,
        testSpecData: backUpTestSpecData,
        folders: backUpFolders,
        relationFolderList: backUpRelationFolderList,
        lastUpdated: 0,
      ));
    } catch (err) {
      return err.toString();
    }
  }

  /// Removes the [BackUp] object from Firebase.
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> removeBackUp() async {
    User? user = _auth.currentUser;
    await user?.reload();

    try {
      final kanjiSnapshot = await _ref
          .collection(collection)
          .doc(user?.uid)
          .collection(kanjiLabel)
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

      WriteBatch? batch = _ref.batch();

      if (kanjiSnapshot.size > 0 && listsSnapshot.size > 0) {
        for (int x = 0; x < kanjiSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(kanjiLabel)
              .doc(Word.fromJson(kanjiSnapshot.docs[x].data()).word));
          batch = await _reinitializeBatch(batch, x);
        }
        for (int x = 0; x < listsSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(listsLabel)
              .doc(WordList.fromJson(listsSnapshot.docs[x].data()).name));
          batch = await _reinitializeBatch(batch, x);
        }
      }

      if (foldersSnapshot.size > 0) {
        for (int x = 0; x < foldersSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(foldersLabel)
              .doc(Folder.fromJson(foldersSnapshot.docs[x].data()).folder));
          batch = await _reinitializeBatch(batch, x);
        }
      }

      if (testDataSnapshot.size > 0) {
        batch?.delete(_ref
            .collection(collection)
            .doc(user?.uid)
            .collection(testsLabel)
            .doc(TestData.fromJson(testDataSnapshot.docs[0].data())
                .statsId
                .toString()));
        batch = await _reinitializeBatch(batch, 499);
      }

      if (relFolderKanListSnapshot.size > 0) {
        for (int x = 0; x < relFolderKanListSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(relFolderKanListLabel)
              .doc(x.toString()));
          batch = await _reinitializeBatch(batch, x);
        }
      }

      if (testSpecDataSnapshot.size > 0) {
        for (int x = 0; x < testSpecDataSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(user?.uid)
              .collection(testSpecsLabel)
              .doc(SpecificData.fromJson(testSpecDataSnapshot.docs[x].data())
                  .id
                  .toString()));
          batch = await _reinitializeBatch(batch, x);
        }
      }

      batch?.delete(_ref.collection(collection).doc(user?.uid));
      await batch?.commit();
      return "";
    } catch (err) {
      return err.toString();
    }
  }

  /// Gets the "last backup time" from Firebase.
  /// Returns the actual parsed date as a String if nothing happened, else,
  /// the error is returned.
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
}
