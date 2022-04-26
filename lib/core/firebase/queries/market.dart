import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/market_queries.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/core/utils/general_utils.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class MarketRecords {
  late FirebaseFirestore _ref;
  late FirebaseAuth _auth;
  final String collection = "Market";
  final String kanjiLabel = "Kanji";

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
    if (max % 500 == 0) {
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
    String? offsetDocumentId,
    required Function(String) onLastQueriedDocument
  }) async {
    try {
      final List<MarketList> lists = [];

      final DocumentSnapshot startFrom = await _ref.collection(collection).doc(offsetDocumentId).get();
      final listsSnapshot = await _ref.collection(collection)
          .orderBy(filter.filter, descending: descending)
          .limit(LazyLoadingLimits.kanList)
          .startAtDocument(startFrom).get();

      if (listsSnapshot.size > 0) {
        for (int x = 0; x < listsSnapshot.size; x++) {
          lists.add(MarketList.fromJson(listsSnapshot.docs[x].data()));
          if (x == listsSnapshot.size - 1) onLastQueriedDocument(listsSnapshot.docs[x].id);
        }
        return lists;
      } else {
        return [];
      }
    } catch (err) {
      print (err);
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
    String? offsetDocumentId,
    required Function(String) onLastQueriedDocument
  }) async {
    try {
      final List<MarketList> lists = [];

      final DocumentSnapshot startFrom = await _ref.collection(collection).doc(offsetDocumentId).get();
      final listsSnapshot = await _ref.collection(collection)
          .limit(LazyLoadingLimits.kanList)
          .startAtDocument(startFrom).get();

      if (listsSnapshot.size > 0) {
        for (int x = 0; x < listsSnapshot.size; x++) {
          lists.add(MarketList.fromJson(listsSnapshot.docs[x].data()));
          if (x == listsSnapshot.size - 1) onLastQueriedDocument(listsSnapshot.docs[x].id);
        }
        return lists;
      } else {
        return [];
      }
    } catch (err) {
      print (err);
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

    if (_user == null) return -2;

    try {
      var batch = _ref.batch();

      final MarketList resetList = MarketList(
        list: list.copyWithReset(),
        author: _user.uid,
        description: description,
        updatedToMarket: GeneralUtils.getCurrentMilliseconds()
      );
      final List<Kanji> resetKanji = [];
      for (var k in resetKanji) {
        resetKanji.add(k.copyWithReset());
      }

      final DocumentReference doc = _ref.collection(collection).doc();

      /// List
      batch.set(doc, resetList.toJson());

      /// Kanji list
      for (int x = 0; x < resetKanji.length; x++) {
        final DocumentReference k = doc.collection(kanjiLabel).doc(resetKanji[x].kanji);
        batch.set(k, resetKanji[x].toJson());
        batch = await _reinitializeBatch(batch, x);
      }

      await batch.commit();
      return 0;
    } catch (err) {
      print (err);
      return -1;
    }
  }

  /// Downloads a Kanlist from the market place to the user's device.
  ///
  /// The [id] comes from the Firebase document id when retrieving the lists.
  Future<String> downloadFromMarketPlace(String id) async {
    try {
      final listSnapshot = await _ref.collection(collection).doc(id).get();
      final listData = listSnapshot.data();
      final kanjiSnapshot = await _ref.collection(collection).doc(id).collection(kanjiLabel).get();

      late KanjiList backUpList;
      List<Kanji> backUpKanji = [];

      if (kanjiSnapshot.size > 0 && listSnapshot.exists && listData != null) {
        backUpList = MarketList.fromJson(listData).list;

        for (int x = 0; x < kanjiSnapshot.size; x++) {
          backUpKanji.add(Kanji.fromJson(kanjiSnapshot.docs[x].data()));
        }
      }

      return await MarketQueries.instance.mergeMarketListIntoDb(backUpList, backUpKanji);
    } catch (err) {
      return err.toString();
    }
  }
}