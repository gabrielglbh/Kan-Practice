import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/database/queries/market_queries.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/queries/market.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class MarketFolderRecords {
  late FirebaseFirestore _ref;
  late FirebaseAuth _auth;

  MarketFolderRecords._() {
    _ref = FirebaseUtils.instance.dbRef;
    _auth = FirebaseUtils.instance.authRef;
  }

  static final MarketFolderRecords _instance = MarketFolderRecords._();

  /// Singleton instance of [MarketFolderRecords]
  static MarketFolderRecords get instance => _instance;

  /// We make sure that when the limit of 500 WRITES per batch is met,
  /// we commit the current batch and initialize it again to perform
  /// more operations.
  Future<WriteBatch> _reinitializeBatch(WriteBatch curr, int max) async {
    if ((max + 1) % 500 == 0) {
      await curr.commit();
      return _ref.batch();
    } else {
      return curr;
    }
  }

  /// Uploads a Folder to the market place. Every list and kanji will be
  /// reset upon upload.
  /// [list] and [kanji] will reset their win rates and dates upon upload.
  ///
  /// In order to be able to upload to the market place, AN USER MUST BE AUTHENTICATED,
  /// else, -2 will be returned
  Future<int> uploadToMarketPlace(
    String name,
    Folder folder,
    List<WordList> lists,
    List<Word> kanji,
    String description,
  ) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return -2;
    } else {
      try {
        var batch = _ref.batch();

        /// Initialize the document with ID as list.name
        final DocumentReference doc =
            _ref.collection(MarketRecords.instance.collection).doc(name);

        /// If the doc already exists, abort
        if ((await doc.get()).exists) {
          return -3;
        }

        /// Initialize Market, KanList and Kanjis
        final Market market = Market(
          name: name,
          words: kanji.length,
          uid: user.uid,
          author: user.displayName ?? "",
          description: description,
          uploadedToMarket: Utils.getCurrentMilliseconds(),
          isFolder: true,
        ).copyWithKeywords();

        final Folder resetFolder = folder.copyWithReset();
        final List<RelationFolderList> relations = [];
        final List<WordList> resetLists = [];
        for (var k in lists) {
          resetLists.add(k.copyWithReset());
          relations.add(RelationFolderList(
            folder: folder.folder,
            kanListName: k.name,
          ));
        }
        final List<Word> resetKanji = [];
        for (var k in kanji) {
          resetKanji.add(k.copyWithReset());
        }

        /// Market List
        batch.set(doc, market.toJson());

        /// Folder
        final DocumentReference k = doc
            .collection(MarketRecords.instance.folderLabel)
            .doc(resetFolder.folder);
        batch.set(k, resetFolder.toJson());

        /// Relations Folder-KanList
        for (int x = 0; x < relations.length; x++) {
          final DocumentReference k = doc
              .collection(MarketRecords.instance.relationsKLLabel)
              .doc(x.toString());
          batch.set(k, relations[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        /// KanList
        for (int x = 0; x < resetLists.length; x++) {
          final DocumentReference k = doc
              .collection(MarketRecords.instance.listLabel)
              .doc(resetLists[x].name);
          batch.set(k, resetLists[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        /// Kanji list
        for (int x = 0; x < resetKanji.length; x++) {
          final DocumentReference k = doc
              .collection(MarketRecords.instance.kanjiLabel)
              .doc(resetKanji[x].kanji);
          batch.set(k, resetKanji[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        await batch.commit();
        return 0;
      } catch (err) {
        print(err);
        return -1;
      }
    }
  }

  /// Downloads a Folder and subsequent KanLists from the market place to the user's device.
  ///
  /// The [id] comes from the Firebase document id when retrieving the lists.
  Future<String> downloadFromMarketPlace(String id) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        final collection = MarketRecords.instance.collection;

        /// Get sub collections for Folder, Relations, KanList and Kanji
        final folderSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.folderLabel)
            .get();
        final relationSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.relationsKLLabel)
            .get();
        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.listLabel)
            .get();
        final kanjiSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.kanjiLabel)
            .get();

        late Folder backUpFolder;
        List<RelationFolderList> backUpRelations = [];
        List<WordList> backUpList = [];
        List<Word> backUpKanji = [];

        /// Apply the transform to the POJO
        backUpFolder = Folder.fromJson(folderSnapshot.docs.first.data());
        if (relationSnapshot.size > 0) {
          for (var m in relationSnapshot.docs) {
            backUpRelations.add(RelationFolderList.fromJson(m.data()));
          }
        }
        if (kanjiSnapshot.size > 0 && listSnapshot.size > 0) {
          for (var m in listSnapshot.docs) {
            backUpList.add(WordList.fromJson(m.data()).copyWithReset());
          }

          for (var m in kanjiSnapshot.docs) {
            backUpKanji.add(Word.fromJson(m.data()));
          }
        }

        /// Update downloads on the list with a transaction
        final ref = _ref.collection(collection).doc(id);
        await _ref.runTransaction((transaction) async {
          transaction
              .update(ref, {Market.downloadField: FieldValue.increment(1)});
        });

        /// Merge it on the DB
        return await MarketQueries.instance.mergeMarketFolderIntoDb(
            backUpFolder, backUpRelations, backUpList, backUpKanji);
      } catch (err) {
        return err.toString();
      }
    }
  }

  /// Remove a Folder and subsequent KanLists from the market place to the user's device.
  ///
  /// The [id] comes from the Firebase document id when retrieving the lists.
  Future<String> removeFromMarketPlace(String id) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        final collection = MarketRecords.instance.collection;

        /// Get all sub collections from the Market List
        final market = _ref.collection(collection).doc(id);

        /// If the user is not the author of the list, exit
        if (_auth.currentUser?.uid !=
            (await market.get()).get(Market.uidField)) {
          return "market_need_to_be_author".tr();
        }

        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.listLabel)
            .get();
        final kanjiSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.kanjiLabel)
            .get();
        final folderSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.folderLabel)
            .get();
        final relationSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(MarketRecords.instance.relationsKLLabel)
            .get();

        /// Use transaction to avoid race errors
        await _ref.runTransaction((transaction) async {
          transaction.delete((folderSnapshot.docs.first.reference));
          for (var x in relationSnapshot.docs) {
            transaction.delete((x.reference));
          }
          for (var x in listSnapshot.docs) {
            transaction.delete((x.reference));
          }
          for (var x in kanjiSnapshot.docs) {
            transaction.delete((x.reference));
          }
          transaction.delete(market);
        });
        return "";
      } catch (err) {
        print(err);
        return err.toString();
      }
    }
  }
}
