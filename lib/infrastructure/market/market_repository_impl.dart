import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/domain/market/i_market_repository.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/infrastructure/folder/folder_repository_impl.dart';
import 'package:kanpractice/infrastructure/list/list_repository_impl.dart';
import 'package:kanpractice/infrastructure/relation_folder_list/relation_foldeR_list_repository_impl.dart';
import 'package:kanpractice/infrastructure/word/word_repository_impl.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

class MarketRepositoryImpl implements IMarketRepository {
  final String collection = "Market";
  final String kanjiLabel = "Kanji";
  final String listLabel = "List";
  final String folderLabel = "Folder";
  final String relationsKLLabel = "RelationsKL";

  final FirebaseFirestore _ref;
  final FirebaseAuth _auth;
  final Database _database;

  MarketRepositoryImpl(this._ref, this._auth, this._database);

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

  @override
  Future<String> downloadFolderFromMarketPlace(String id) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        /// Get sub collections for Folder, Relations, KanList and Kanji
        final folderSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(folderLabel)
            .get();
        final relationSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(relationsKLLabel)
            .get();
        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(listLabel)
            .get();
        final kanjiSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(kanjiLabel)
            .get();

        late Folder backUpFolder;
        List<RelationFolderList> backUpRelations = [];
        List<WordList> backUpList = [];
        List<Word> backUpWords = [];

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
            backUpWords.add(Word.fromJson(m.data()));
          }
        }

        /// Update downloads on the list with a transaction
        final ref = _ref.collection(collection).doc(id);
        await _ref.runTransaction((transaction) async {
          transaction
              .update(ref, {Market.downloadField: FieldValue.increment(1)});
        });

        /// Merge it on the DB
        Batch? batch = _database.batch();

        /// Check if the folder is already installed
        final f = await FolderRepositoryImpl(_database)
            .getFolder(backUpFolder.folder);
        if (f.folder == backUpFolder.folder) {
          return "market_download_already_installed".tr();
        }

        batch = await FolderRepositoryImpl(_database)
            .mergeFolders(batch, [backUpFolder], ConflictAlgorithm.ignore);

        /// Order matters as kanji depends on lists.
        /// Conflict algorithm allows us to ignore if the insertion if the list already exists.
        batch = await ListRepositoryImpl(_database)
            .mergeLists(batch, backUpList, ConflictAlgorithm.ignore);

        batch = await WordRepositoryImpl(_database)
            .mergeWords(batch, backUpWords, ConflictAlgorithm.ignore);

        batch = await RelationFolderListRepositoryImpl(_database)
            .mergeRelationFolderList(
                batch, backUpRelations, ConflictAlgorithm.ignore);

        final results = await batch?.commit();
        return results?.isEmpty == true
            ? "backup_queries_mergeBackUp_failed".tr()
            : "";
      } catch (err) {
        return err.toString();
      }
    }
  }

  @override
  Future<String> downloadListFromMarketPlace(String id) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        /// Get sub collections for KanList and Kanji
        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(listLabel)
            .get();
        final kanjiSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(kanjiLabel)
            .get();

        late WordList backUpList;
        List<Word> backUpWords = [];

        /// Apply the transform to the POJO
        if (kanjiSnapshot.size > 0 && listSnapshot.size > 0) {
          backUpList = WordList.fromJson(listSnapshot.docs[0].data());
          backUpList = backUpList.copyWithReset();

          for (int x = 0; x < kanjiSnapshot.size; x++) {
            backUpWords.add(Word.fromJson(kanjiSnapshot.docs[x].data()));
          }
        }

        /// Update downloads on the list with a transaction
        final ref = _ref.collection(collection).doc(id);
        await _ref.runTransaction((transaction) async {
          transaction
              .update(ref, {Market.downloadField: FieldValue.increment(1)});
        });

        /// Merge it on the DB
        /// Check if the list is already installed
        final l = await ListRepositoryImpl(_database).getList(backUpList.name);
        if (l.name == backUpList.name) {
          return "market_download_already_installed".tr();
        }

        /// Order matters as kanji depends on lists.
        /// Conflict algorithm allows us to ignore if the insertion if the list already exists.
        Batch? batch = _database.batch();

        batch = await ListRepositoryImpl(_database)
            .mergeLists(batch, [backUpList], ConflictAlgorithm.ignore);

        batch = await WordRepositoryImpl(_database)
            .mergeWords(batch, backUpWords, ConflictAlgorithm.ignore);

        final results = await batch?.commit();
        return results?.isEmpty == true
            ? "backup_queries_mergeBackUp_failed".tr()
            : "";
      } catch (err) {
        return err.toString();
      }
    }
  }

  @override
  Future<List<Market>> getMarket(
      {MarketFilters filter = MarketFilters.all,
      bool descending = true,
      required String offsetDocumentId,
      required Function(String p1) onLastQueriedDocument,
      String? query,
      bool filterByMine = false}) async {
    try {
      final List<Market> lists = [];
      late QuerySnapshot<Map<String, dynamic>> snapshot;

      /// QuerySnapshot instances must be completed within itself, thus this conditional
      /// block.
      if (query == null) {
        /// Lazy loading
        if (offsetDocumentId.isNotEmpty) {
          final DocumentSnapshot startFrom =
              await _ref.collection(collection).doc(offsetDocumentId).get();

          if (!filterByMine) {
            snapshot = await _ref
                .collection(collection)
                .orderBy(filter.filter, descending: descending)
                .startAfterDocument(startFrom)
                .limit(LazyLoadingLimits.kanList)
                .get();
          } else {
            snapshot = await _ref
                .collection(collection)
                .startAfterDocument(startFrom)
                .where(Market.uidField, isEqualTo: _auth.currentUser?.uid)
                .limit(LazyLoadingLimits.kanList)
                .get();
          }
        }

        /// Initial loading
        else {
          if (!filterByMine) {
            snapshot = await _ref
                .collection(collection)
                .orderBy(filter.filter, descending: descending)
                .limit(LazyLoadingLimits.kanList)
                .get();
          } else {
            snapshot = await _ref
                .collection(collection)
                .where(Market.uidField, isEqualTo: _auth.currentUser?.uid)
                .limit(LazyLoadingLimits.kanList)
                .get();
          }
        }
      }

      /// Searching queries WITHOUT filter nor order
      else {
        /// Lazy Loading
        if (offsetDocumentId.isNotEmpty) {
          final DocumentSnapshot startFrom =
              await _ref.collection(collection).doc(offsetDocumentId).get();

          if (!filterByMine) {
            snapshot = await _ref
                .collection(collection)
                .where(Market.keywordsField, arrayContains: query.toLowerCase())
                .startAfterDocument(startFrom)
                .limit(LazyLoadingLimits.kanList)
                .get();
          } else {
            snapshot = await _ref
                .collection(collection)
                .startAfterDocument(startFrom)
                .where(Market.keywordsField, arrayContains: query.toLowerCase())
                .where(Market.uidField, isEqualTo: _auth.currentUser?.uid)
                .limit(LazyLoadingLimits.kanList)
                .get();
          }
        } else {
          if (!filterByMine) {
            snapshot = await _ref
                .collection(collection)
                .where(Market.keywordsField, arrayContains: query.toLowerCase())
                .limit(LazyLoadingLimits.kanList)
                .get();
          } else {
            snapshot = await _ref
                .collection(collection)
                .where(Market.uidField, isEqualTo: _auth.currentUser?.uid)
                .where(Market.keywordsField, arrayContains: query.toLowerCase())
                .limit(LazyLoadingLimits.kanList)
                .get();
          }
        }
      }

      if (snapshot.size > 0) {
        /// Assures that the Lazy Loading is correct
        if (offsetDocumentId == snapshot.docs[snapshot.size - 1].id) {
          return [];
        }

        for (int x = 0; x < snapshot.size; x++) {
          lists.add(Market.fromJson(snapshot.docs[x].data()));
          if (x == snapshot.size - 1) {
            onLastQueriedDocument(snapshot.docs[x].id);
          }
        }
        return lists;
      } else {
        return [];
      }
    } catch (err) {
      print(err);
      return [];
    }
  }

  @override
  Future<String> rateList(String id, double rate) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        /// Get Market document
        final marketDoc = _ref.collection(collection).doc(id);
        final marketData = await marketDoc.get();

        if (marketData.exists) {
          /// Use transaction to avoid race errors
          /// We use nested access to properly update the rating system
          await _ref.runTransaction((transaction) async {
            final doc = await transaction.get(marketDoc);
            if (doc.exists) {
              /// Update the current rating map with the new or already rated user score
              transaction.update(
                  marketDoc, {"${Market.ratingMapField}.${user.uid}": rate});

              /// Get the number of entries in the map and calculate the average
              final ratings =
                  doc.get(Market.ratingMapField) as Map<String, dynamic>;
              ratings[user.uid] = rate;
              final ratingsValues = ratings.values.toList().cast<double>();

              /// If ratingValues is empty, mean will be equal to the first value: rate.
              /// Else, the average of the list will be calculated and stored.
              double mean = rate;
              if (ratingsValues.isNotEmpty || ratingsValues.length > 1) {
                mean = ratingsValues.average;
              }

              /// Update the rating double field
              transaction.update(marketDoc, {Market.ratingField: mean});
            }
          });
        } else {
          return "market_rating_not_found".tr();
        }
        return "";
      } catch (err) {
        return "$id: ${err.toString()}";
      }
    }
  }

  @override
  Future<String> removeFolderFromMarketPlace(String id) async {
    User? user = _auth.currentUser;
    await user?.reload();
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
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
            .collection(listLabel)
            .get();
        final kanjiSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(kanjiLabel)
            .get();
        final folderSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(folderLabel)
            .get();
        final relationSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(relationsKLLabel)
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

  @override
  Future<String> removeListFromMarketPlace(String id) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
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
            .collection(listLabel)
            .get();
        final kanjiSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(kanjiLabel)
            .get();

        /// Use transaction to avoid race errors
        await _ref.runTransaction((transaction) async {
          for (var x = 0; x < listSnapshot.size; x++) {
            transaction.delete((listSnapshot.docs[x].reference));
          }
          for (var x = 0; x < kanjiSnapshot.size; x++) {
            transaction.delete((kanjiSnapshot.docs[x].reference));
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

  @override
  Future<int> uploadFolderToMarketPlace(String name, Folder folder,
      List<WordList> lists, List<Word> words, String description) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return -2;
    } else {
      try {
        var batch = _ref.batch();

        /// Initialize the document with ID as list.name
        final DocumentReference doc = _ref.collection(collection).doc(name);

        /// If the doc already exists, abort
        if ((await doc.get()).exists) {
          return -3;
        }

        /// Initialize Market, KanList and Kanjis
        final Market market = Market(
          name: name,
          words: words.length,
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
            list: k.name,
          ));
        }
        final List<Word> resetKanji = [];
        for (var k in words) {
          resetKanji.add(k.copyWithReset());
        }

        /// Market List
        batch.set(doc, market.toJson());

        /// Folder
        final DocumentReference k =
            doc.collection(folderLabel).doc(resetFolder.folder);
        batch.set(k, resetFolder.toJson());

        /// Relations Folder-KanList
        for (int x = 0; x < relations.length; x++) {
          final DocumentReference k =
              doc.collection(relationsKLLabel).doc(x.toString());
          batch.set(k, relations[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        /// KanList
        for (int x = 0; x < resetLists.length; x++) {
          final DocumentReference k =
              doc.collection(listLabel).doc(resetLists[x].name);
          batch.set(k, resetLists[x].toJson());
          batch = await _reinitializeBatch(batch, x);
        }

        /// Kanji list
        for (int x = 0; x < resetKanji.length; x++) {
          final DocumentReference k =
              doc.collection(kanjiLabel).doc(resetKanji[x].word);
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

  @override
  Future<int> uploadListToMarketPlace(
      String name, WordList list, List<Word> words, String description) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return -2;
    } else {
      try {
        var batch = _ref.batch();

        /// Initialize the document with ID as list.name
        final DocumentReference doc = _ref.collection(collection).doc(name);

        /// If the doc already exists, abort
        if ((await doc.get()).exists) {
          return -3;
        }

        /// Initialize Market, KanList and Kanjis
        final Market resetList = Market(
                name: name,
                words: words.length,
                uid: user.uid,
                author: user.displayName ?? "",
                description: description,
                uploadedToMarket: Utils.getCurrentMilliseconds())
            .copyWithKeywords();

        final WordList raw = list.copyWithReset();
        final List<Word> resetKanji = [];
        for (var k in words) {
          resetKanji.add(k.copyWithReset());
        }

        /// Market List
        batch.set(doc, resetList.toJson());

        /// KanList
        final DocumentReference k = doc.collection(listLabel).doc(raw.name);
        batch.set(k, raw.toJson());

        await batch.commit();

        /// Kanji list
        batch = _ref.batch();
        for (int x = 0; x < resetKanji.length; x++) {
          final DocumentReference k =
              doc.collection(kanjiLabel).doc(resetKanji[x].word);
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
}
