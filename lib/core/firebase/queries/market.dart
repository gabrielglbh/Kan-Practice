import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/market_queries.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:collection/collection.dart';

class MarketRecords {
  late FirebaseFirestore _ref;
  late FirebaseAuth _auth;
  final String collection = "Market";
  final String kanjiLabel = "Kanji";
  final String listLabel = "List";

  MarketRecords._() {
    _ref = FirebaseUtils.instance.dbRef;
    _auth = FirebaseUtils.instance.authRef;
  }

  static final MarketRecords _instance = MarketRecords._();

  /// Singleton instance of [MarketRecords]
  static MarketRecords get instance => _instance;

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

  /// Query to get all [MarketList] from Firebase with an optional [order] and [filter].
  /// If anything goes wrong, an empty list will be returned.
  ///
  /// The offset is the last document id retrieved from Firebase. This is kept
  /// on the MarketBloc for the whole instance of the page instead of this singleton.
  /// The string of the last retrieved document is updated via [onLastQueriedDocument].
  Future<List<MarketList>> getLists({
    MarketFilters filter = MarketFilters.all,
    bool descending = true,
    required String offsetDocumentId,
    required Function(String) onLastQueriedDocument,
    bool filterByMine = false
  }) async {
    try {
      final List<MarketList> lists = [];
      /// Apply filter, order and limit for Lazy loading purposes
      final Query<Map<String, dynamic>> listsSnapshot = _ref.collection(collection)
          .orderBy(filter.filter, descending: descending)
          .limit(LazyLoadingLimits.kanList);

      /// If there is an offset, apply it to the query
      if (offsetDocumentId.isNotEmpty) {
        final DocumentSnapshot startFrom = await _ref.collection(collection)
            .doc(offsetDocumentId).get();
        listsSnapshot.startAfterDocument(startFrom);
      }

      /// If the user wants to retrieve only his or her lists
      if (filterByMine) {
        listsSnapshot.where(MarketList.uidField, isEqualTo: _auth.currentUser?.uid);
      }

      final snapshot = await listsSnapshot.get();

      if (snapshot.size > 0) {
        /// Assures that the Lazy Loading is correct
        if (offsetDocumentId == snapshot.docs[snapshot.size - 1].id) {
          return [];
        }

        for (int x = 0; x < snapshot.size; x++) {
          lists.add(MarketList.fromJson(snapshot.docs[x].data()));
          if (x == snapshot.size - 1) onLastQueriedDocument(snapshot.docs[x].id);
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

  /// Query to get all [MarketList] from Firebase matching [query].
  /// If anything goes wrong, an empty list will be returned.
  ///
  /// The offset is the last document id retrieved from Firebase. This is kept
  /// on the MarketBloc for the whole instance of the page instead of this singleton.
  /// The string of the last retrieved document is updated via [onLastQueriedDocument].
  /// 
  /// TODO: Set keywords on MarketList for matching queries
  Future<List<MarketList>> getListsBasedOnQuery(String query, {
    MarketFilters filter = MarketFilters.all,
    bool descending = true,
    required String offsetDocumentId,
    required Function(String) onLastQueriedDocument,
    bool filterByMine = false
  }) async {
    try {
      final List<MarketList> lists = [];
      /// Apply filter, order and limit for Lazy loading purposes
      final Query<Map<String, dynamic>> listsSnapshot = _ref.collection(collection)
          .limit(LazyLoadingLimits.kanList);

      /// If there is an offset, apply it to the query
      if (offsetDocumentId.isNotEmpty) {
        final DocumentSnapshot startFrom = await _ref.collection(collection)
            .doc(offsetDocumentId).get();
        listsSnapshot.startAfterDocument(startFrom);
      }

      /// If the user wants to retrieve only his or her lists
      if (filterByMine) {
        listsSnapshot.where(MarketList.uidField, isEqualTo: _auth.currentUser?.uid);
      }

      final snapshot = await listsSnapshot.get();

      if (snapshot.size > 0) {
        /// Assures that the Lazy Loading is correct
        if (offsetDocumentId == snapshot.docs[snapshot.size - 1].id) {
          return [];
        }

        for (int x = 0; x < snapshot.size; x++) {
          lists.add(MarketList.fromJson(snapshot.docs[x].data()));
          if (x == snapshot.size - 1) onLastQueriedDocument(snapshot.docs[x].id);
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

  /// Uploads a Kanlist to the market place. Every list and kanji will be
  /// reset upon upload.
  /// [list] and [kanji] will reset their win rates and dates upon upload.
  ///
  /// In order to be able to upload to the market place, AN USER MUST BE AUTHENTICATED,
  /// else, -2 will be returned
  Future<int> uploadToMarketPlace(KanjiList list, List<Kanji> kanji, String description) async {
    User? _user = _auth.currentUser;
    await _user?.reload();

    /// If the user is not authenticated, exit
    if (_user == null) {
      return -2;
    } else {
      try {
        var batch = _ref.batch();

        /// Initialize the document with ID as list.name
        final DocumentReference doc = _ref.collection(collection).doc(list.name);

        /// If the doc already exists, abort
        if ((await doc.get()).exists) {
          return -3;
        }

        /// Initialize MarketList, KanList and Kanjis
        final MarketList resetList = MarketList(
            name: list.name,
            words: kanji.length,
            uid: _user.uid,
            author: _user.displayName ?? "",
            description: description,
            uploadedToMarket: GeneralUtils.getCurrentMilliseconds()
        );
        final KanjiList raw = list.copyWithReset();
        final List<Kanji> resetKanji = [];
        for (var k in kanji) {
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
          final DocumentReference k = doc.collection(kanjiLabel).doc(resetKanji[x].kanji);
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

  /// Downloads a Kanlist from the market place to the user's device.
  ///
  /// The [id] comes from the Firebase document id when retrieving the lists.
  Future<String> downloadFromMarketPlace(String id) async {
    User? _user = _auth.currentUser;
    await _user?.reload();

    /// If the user is not authenticated, exit
    if (_user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        /// Get sub collections for KanList and Kanji
        final listSnapshot = await _ref.collection(collection).doc(id)
            .collection(listLabel).get();
        final kanjiSnapshot = await _ref.collection(collection).doc(id)
            .collection(kanjiLabel).get();

        late KanjiList backUpList;
        List<Kanji> backUpKanji = [];

        /// Apply the transform to the POJO
        if (kanjiSnapshot.size > 0 && listSnapshot.size > 0) {
          backUpList = KanjiList.fromJson(listSnapshot.docs[0].data());
          backUpList = backUpList.copyWithReset();

          for (int x = 0; x < kanjiSnapshot.size; x++) {
            backUpKanji.add(Kanji.fromJson(kanjiSnapshot.docs[x].data()));
          }
        }

        /// Update downloads on the list with a transaction
        final ref = _ref.collection(collection).doc(id);
        await _ref.runTransaction((transaction) async {
          transaction.update(ref, { MarketList.downloadField: FieldValue.increment(1) });
        });

        /// Merge it on the DB
        return await MarketQueries.instance.mergeMarketListIntoDb(backUpList, backUpKanji);
      } catch (err) {
        return err.toString();
      }
    }
  }

  /// Remove a Kanlist from the market place to the user's device.
  ///
  /// The [id] comes from the Firebase document id when retrieving the lists.
  Future<String> removeFromMarketPlace(String id) async {
    User? _user = _auth.currentUser;
    await _user?.reload();

    /// If the user is not authenticated, exit
    if (_user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        /// Get all sub collections from the Market List
        final marketList = _ref.collection(collection).doc(id);

        /// If the user is not the author of the list, exit
        if (_auth.currentUser?.uid != (await marketList.get()).get(MarketList.uidField)) {
          return "market_need_to_be_author".tr();
        }

        final listSnapshot = await _ref.collection(collection).doc(id).collection(listLabel).get();
        final kanjiSnapshot = await _ref.collection(collection).doc(id).collection(kanjiLabel).get();

        /// Use transaction to avoid race errors
        await _ref.runTransaction((transaction) async {
          for (var x = 0; x < listSnapshot.size; x++) {
            transaction.delete((listSnapshot.docs[x].reference));
          }
          for (var x = 0; x < kanjiSnapshot.size; x++) {
            transaction.delete((kanjiSnapshot.docs[x].reference));
          }
          transaction.delete(marketList);
        });
        return "";
      } catch (err) {
        print(err);
        return err.toString();
      }
    }
  }

  Future<String> rateList(String id, double rate) async {
    User? _user = _auth.currentUser;
    await _user?.reload();

    /// If the user is not authenticated, exit
    if (_user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        /// Get MarketList document
        final marketListDoc = _ref.collection(collection).doc(id);
        final marketListData = await marketListDoc.get();

        if (marketListData.exists) {
          /// Use transaction to avoid race errors
          /// We use nested access to properly update the rating system
          await _ref.runTransaction((transaction) async {
            final doc = await transaction.get(marketListDoc);
            if (doc.exists) {
              /// Update the current rating map with the new or already rated user score
              transaction.update(marketListDoc, {
                "${MarketList.ratingMapField}.${_user.uid}": rate
              });
              /// Get the number of entries in the map and calculate the average
              final ratings = doc.get(MarketList.ratingMapField) as Map<String, dynamic>;
              ratings[_user.uid] = rate;
              final ratingsValues = ratings.values.toList().cast<double>();
              /// If ratingValues is empty, mean will be equal to the first value: rate.
              /// Else, the average of the list will be calculated and stored.
              double mean = rate;
              if (ratingsValues.isNotEmpty || ratingsValues.length > 1) {
                mean = ratingsValues.average;
              }
              /// Update the rating double field
              transaction.update(marketListDoc, {
                MarketList.ratingField: mean
              });
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
}