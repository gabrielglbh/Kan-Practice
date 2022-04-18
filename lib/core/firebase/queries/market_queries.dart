import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/firebase/firebase.dart';

class MarketQueries {
  FirebaseFirestore? _ref;
  final String collection = "Market";
  final String kanjiLabel = "Kanji";
  final String listsLabel = "Lists";

  MarketQueries._() {
    _ref = FirebaseUtils.instance.dbRef;
  }

  static final MarketQueries _instance = MarketQueries._();

  /// Singleton instance of [MarketQueries]
  static MarketQueries get instance => _instance;

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

  /// Uploads a Kanlist to the market place
  ///
  /// [list] and [kanji] will reset their win rates and dates upon upload.
  Future<void> uploadToMarketPlace(KanjiList list, List<Kanji> kanji) async {
    var batch = _ref?.batch();

    // TODO: Reset win rates and dates before upload

    final DocumentReference doc = FirebaseFirestore.instance.collection(collection).doc();

    /// List
    batch?.set(doc, list.toJson());

    /// Kanji list
    for (int x = 0; x < kanji.length; x++) {
      final DocumentReference k = doc.collection(kanjiLabel).doc(kanji[x].kanji);
      batch?.set(k, kanji[x].toJson());
      batch = await _reinitializeBatch(batch, x);
    }
  }

  /// Downloads a Kanlist from the market place to the user's device
  Future<void> downloadFromMarketPlace(String id) async {
    // TODO: If the kanji is already present, IGNORE and continue
  }
}