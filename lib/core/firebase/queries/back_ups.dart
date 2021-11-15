import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/back_up_queries.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/models/backup.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:easy_localization/easy_localization.dart';

class BackUpRecords {
  FirebaseFirestore? _ref;
  FirebaseAuth? _auth;
  final String collection = "BackUps";
  final String kanjiLabel= "Kanji";
  final String listsLabel = "Lists";

  /// Singleton instance of [BackUpRecords]
  static BackUpRecords instance = BackUpRecords();

  BackUpRecords() {
    _ref = FirebaseUtils.instance.dbRef;
    _auth = FirebaseUtils.instance.authRef;
  }

  /// We make sure that when the limit of 500 WRITES per batch is met,
  /// we commit the current batch and initialize it again to perform
  /// more operations.
  Future<WriteBatch?> _reinitializeBatch(WriteBatch? curr, int max) async {
    if (max % 500 == 0) {
      await curr?.commit();
      return _ref?.batch();
    } else
      return curr;
  }

  /// Gets the latest version of the app from Firebase to check against the current
  /// built version.
  Future<String> getVersion() async {
    try {
      final DocumentSnapshot? ref = await _ref?.collection("Versioning").doc("version").get();
      return await ref?.get("version");
    } catch (err) {
      print(err.toString());
    }
    return "";
  }

  /// Creates the [BackUp] object and creates it in Firebase under the current UID.
  /// Based on sub collections.
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> createBackUp() async {
    User? _user = _auth?.currentUser;
    await _user?.reload();

    List<Kanji> kanji = await KanjiQueries.instance.getAllKanji();
    List<KanjiList> lists = await ListQueries.instance.getAllLists();
    int date = GeneralUtils.getCurrentMilliseconds();

    if (lists.isEmpty) {
      return "backup_firebase_createBackUp_listEmpty".tr();
    } else {
      BackUp backUpObject = BackUp(lists: lists, kanji: kanji, lastUpdated: date);
      WriteBatch? batch = _ref?.batch();
      try {
        /// Making sure the back up only contains the actual data of the device
        await removeBackUp();

        Map<String, dynamic> data = backUpObject.toJson();
        for (int x = 0; x < kanji.length; x++) {
          final DocumentReference doc = _ref?.collection(collection).doc(_user?.uid)
              .collection(kanjiLabel).doc(kanji[x].kanji) as DocumentReference;
          batch?.set(doc, data[BackUp.kanjiLabel][x]);
          batch = await _reinitializeBatch(batch, x);
        }

        for (int x = 0; x < lists.length; x++) {
          final DocumentReference doc = _ref?.collection(collection).doc(_user?.uid)
              .collection(listsLabel).doc(lists[x].name) as DocumentReference;
          batch?.set(doc, data[BackUp.listLabel][x]);
          batch = await _reinitializeBatch(batch, x);
        }

        batch?.set(_ref?.collection(collection).doc(_user?.uid) as DocumentReference, {
          BackUp.updatedLabel: data[BackUp.updatedLabel]
        });

        await batch?.commit();
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
    User? _user = _auth?.currentUser;
    await _user?.reload();

    try {
      final kanjiSnapshot = await _ref?.collection(collection).doc(_user?.uid).collection(kanjiLabel).get();
      final listsSnapshot = await _ref?.collection(collection).doc(_user?.uid).collection(listsLabel).get();

      List<Kanji> backUpKanji = [];
      List<KanjiList> backUpLists = [];

      if (kanjiSnapshot != null && listsSnapshot != null) {
        for (int x = 0; x < kanjiSnapshot.size; x++)
          backUpKanji.add(Kanji.fromJson(kanjiSnapshot.docs[x].data()));
        for (int x = 0; x < listsSnapshot.size; x++)
          backUpLists.add(KanjiList.fromJson(listsSnapshot.docs[x].data()));
      }

      return await BackUpQueries.instance.mergeBackUp(backUpKanji, backUpLists);
    } catch (err) {
      return err.toString();
    }
  }

  /// Removes the [BackUp] object from Firebase.
  /// Returns an empty String if nothing happened, else, the error is returned.
  Future<String> removeBackUp() async {
    User? _user = _auth?.currentUser;
    await _user?.reload();

    try {
      final kanjiSnapshot = await _ref?.collection(collection).doc(_user?.uid).collection(kanjiLabel).get();
      final listsSnapshot = await _ref?.collection(collection).doc(_user?.uid).collection(listsLabel).get();
      WriteBatch? batch = _ref?.batch();

      if (kanjiSnapshot != null && listsSnapshot != null) {
        for (int x = 0; x < kanjiSnapshot.size; x++) {
          batch?.delete(_ref?.collection(collection).doc(_user?.uid).collection(kanjiLabel)
              .doc(Kanji.fromJson(kanjiSnapshot.docs[x].data()).kanji) as DocumentReference);
          batch = await _reinitializeBatch(batch, x);
        }
        for (int x = 0; x < listsSnapshot.size; x++) {
          batch?.delete(_ref?.collection(collection).doc(_user?.uid).collection(listsLabel)
              .doc(KanjiList.fromJson(listsSnapshot.docs[x].data()).name) as DocumentReference);
          batch = await _reinitializeBatch(batch, x);
        }
      }

      batch?.delete(_ref?.collection(collection).doc(_user?.uid) as DocumentReference);
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
    User? _user = _auth?.currentUser;
    await _user?.reload();

    try {
      final snapshot = await _ref?.collection(collection).doc(_user?.uid).get();
      if (snapshot != null) {
        int date = snapshot.get("lastUpdated");
        return "${"backup_firebase_getLastUpdated_successful".tr()} "
            "${GeneralUtils.parseDateMilliseconds(context, date)}";
      } else return "backup_firebase_getLastUpdated_noBackUp".tr();
    } catch (err) {
      return "backup_firebase_getLastUpdated_noBackUp".tr();
    }
  }
}