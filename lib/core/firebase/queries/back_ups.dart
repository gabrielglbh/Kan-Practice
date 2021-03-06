import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/back_up_queries.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/models/backup.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';

class BackUpRecords {
  late FirebaseFirestore _ref;
  late FirebaseAuth _auth;
  final String collection = "BackUps";
  final String kanjiLabel = "Kanji";
  final String listsLabel = "Lists";
  final String testsLabel = "Tests";

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
      final DocumentSnapshot? ref =
          await _ref.collection("Versioning").doc("version").get();
      return await ref?.get("version");
    } catch (err) {
      print(err.toString());
    }
    return "";
  }

  /// Gets the version notes and changelogs of the current version.
  Future<List<String>> getVersionNotes(BuildContext context) async {
    List<String> notes = [];

    try {
      final Future<DocumentSnapshot>? ref =
          _ref.collection("Versioning").doc("version_notes").get();
      await ref?.then((snapshot) {
        notes = snapshot
            .get(Localizations.localeOf(context).languageCode)
            .cast<String>();
      });
    } catch (err) {
      notes = [];
    }
    return notes;
  }

  /// Creates the [BackUp] object and creates it in Firebase under the current UID.
  /// Based on sub collections.
  ///
  /// If [backUpTests] is true, a copy of all current tests will be saved in the back up.
  ///
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> createBackUp({bool backUpTests = false}) async {
    User? _user = _auth.currentUser;
    await _user?.reload();

    List<Kanji> kanji = await KanjiQueries.instance.getAllKanji();
    List<KanjiList> lists = await ListQueries.instance.getAllLists();
    List<Test> test =
        backUpTests ? await TestQueries.instance.getAllTests() : [];
    int date = GeneralUtils.getCurrentMilliseconds();

    if (lists.isEmpty) {
      return "backup_firebase_createBackUp_listEmpty".tr();
    } else {
      BackUp backUpObject =
          BackUp(lists: lists, kanji: kanji, test: test, lastUpdated: date);
      WriteBatch? batch = _ref.batch();
      try {
        /// Making sure the back up only contains the actual data of the device
        await removeBackUp();

        /// Kanji list
        for (int x = 0; x < kanji.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(_user?.uid)
              .collection(kanjiLabel)
              .doc(kanji[x].kanji);
          batch?.set(doc, backUpObject.kanji[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Lists
        for (int x = 0; x < lists.length; x++) {
          final DocumentReference doc = _ref
              .collection(collection)
              .doc(_user?.uid)
              .collection(listsLabel)
              .doc(lists[x].name);
          batch?.set(doc, backUpObject.lists[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Tests
        if (backUpTests && test.isNotEmpty) {
          for (int x = 0; x < test.length; x++) {
            final DocumentReference doc = _ref
                .collection(collection)
                .doc(_user?.uid)
                .collection(testsLabel)
                .doc(test[x].takenDate.toString());
            batch?.set(doc, backUpObject.test[x].toJson());
            batch = await _reinitializeBatch(batch, x);
          }
        }

        await batch?.commit();
        batch = _ref.batch();

        /// Last updated
        batch.set(_ref.collection(collection).doc(_user?.uid),
            {BackUp.updatedLabel: backUpObject.lastUpdated});

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
    User? _user = _auth.currentUser;
    await _user?.reload();

    try {
      final kanjiSnapshot = await _ref
          .collection(collection)
          .doc(_user?.uid)
          .collection(kanjiLabel)
          .get();
      final listsSnapshot = await _ref
          .collection(collection)
          .doc(_user?.uid)
          .collection(listsLabel)
          .get();
      final testsSnapshot = await _ref
          .collection(collection)
          .doc(_user?.uid)
          .collection(testsLabel)
          .get();

      List<Kanji> backUpKanji = [];
      List<KanjiList> backUpLists = [];

      /// If snapshot is null, backUpTests will be empty
      List<Test> backUpTests = [];

      if (kanjiSnapshot.size > 0 && listsSnapshot.size > 0) {
        for (int x = 0; x < kanjiSnapshot.size; x++) {
          backUpKanji.add(Kanji.fromJson(kanjiSnapshot.docs[x].data()));
        }
        for (int x = 0; x < listsSnapshot.size; x++) {
          backUpLists.add(KanjiList.fromJson(listsSnapshot.docs[x].data()));
        }
      }

      if (testsSnapshot.size > 0) {
        for (int x = 0; x < testsSnapshot.size; x++) {
          backUpTests.add(Test.fromJson(testsSnapshot.docs[x].data()));
        }
      }

      return await BackUpQueries.instance
          .mergeBackUp(backUpKanji, backUpLists, backUpTests);
    } catch (err) {
      return err.toString();
    }
  }

  /// Removes the [BackUp] object from Firebase.
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> removeBackUp() async {
    User? _user = _auth.currentUser;
    await _user?.reload();

    try {
      final kanjiSnapshot = await _ref
          .collection(collection)
          .doc(_user?.uid)
          .collection(kanjiLabel)
          .get();
      final listsSnapshot = await _ref
          .collection(collection)
          .doc(_user?.uid)
          .collection(listsLabel)
          .get();
      final testsSnapshot = await _ref
          .collection(collection)
          .doc(_user?.uid)
          .collection(testsLabel)
          .get();

      WriteBatch? batch = _ref.batch();

      if (kanjiSnapshot.size > 0 && listsSnapshot.size > 0) {
        for (int x = 0; x < kanjiSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(_user?.uid)
              .collection(kanjiLabel)
              .doc(Kanji.fromJson(kanjiSnapshot.docs[x].data()).kanji));
          batch = await _reinitializeBatch(batch, x);
        }
        for (int x = 0; x < listsSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(_user?.uid)
              .collection(listsLabel)
              .doc(KanjiList.fromJson(listsSnapshot.docs[x].data()).name));
          batch = await _reinitializeBatch(batch, x);
        }
      }

      if (testsSnapshot.size > 0) {
        for (int x = 0; x < testsSnapshot.size; x++) {
          batch?.delete(_ref
              .collection(collection)
              .doc(_user?.uid)
              .collection(testsLabel)
              .doc(Test.fromJson(testsSnapshot.docs[x].data())
                  .takenDate
                  .toString()));
          batch = await _reinitializeBatch(batch, x);
        }
      }

      batch?.delete(_ref.collection(collection).doc(_user?.uid));
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
    User? _user = _auth.currentUser;
    await _user?.reload();

    try {
      final snapshot = await _ref.collection(collection).doc(_user?.uid).get();
      if (snapshot.exists) {
        int date = snapshot.get("lastUpdated");
        return "${"backup_firebase_getLastUpdated_successful".tr()} "
            "${GeneralUtils.parseDateMilliseconds(context, date)}";
      } else {
        return "backup_firebase_getLastUpdated_noBackUp".tr();
      }
    } catch (err) {
      return "backup_firebase_getLastUpdated_noBackUp".tr();
    }
  }
}
