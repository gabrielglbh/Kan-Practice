import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/presentation/core/types/market_filters.dart';
import 'package:kanpractice/domain/market/i_market_repository.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IMarketRepository)
class MarketRepositoryImpl implements IMarketRepository {
  final String collection = "Market";
  final String wordLabel = "Kanji";
  final String grammarLabel = "Grammar";
  final String listLabel = "List";
  final String folderLabel = "Folder";
  final String relationsKLLabel = "RelationsKL";
  int writes = 0;

  final FirebaseFirestore _ref;
  final FirebaseAuth _auth;
  final Database _database;
  final IFolderRepository _folderRepository;
  final IListRepository _listRepository;
  final IWordRepository _wordRepository;
  final IGrammarPointRepository _grammarPointRepository;
  final IRelationFolderListRepository _relationFolderListRepository;
  final ITranslateRepository _translateRepository;

  MarketRepositoryImpl(
    this._ref,
    this._auth,
    this._database,
    this._folderRepository,
    this._listRepository,
    this._wordRepository,
    this._grammarPointRepository,
    this._relationFolderListRepository,
    this._translateRepository,
  );

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
  Future<String> downloadFolderFromMarketPlace(
      String id, String targetLanguage) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        final marketSnapshot = await _ref.collection(collection).doc(id).get();

        /// Get sub collections for Folder, Relations, KanList and Word
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
        final wordSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(wordLabel)
            .get();
        final grammarSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(grammarLabel)
            .get();

        late Folder backUpFolder;
        List<RelationFolderList> backUpRelations = [];
        List<WordList> backUpList = [];
        List<Word> backUpWords = [];
        List<GrammarPoint> backUpGrammar = [];

        final originLanguage = marketSnapshot.get('language') as String;

        /// Apply the transform to the POJO
        backUpFolder = Folder.fromJson(folderSnapshot.docs.first.data());

        /// Check if the folder is already installed
        final f = await _folderRepository.getFolder(backUpFolder.folder);
        if (f.folder == backUpFolder.folder) {
          return "market_download_already_installed".tr();
        }

        if (relationSnapshot.size > 0) {
          for (var m in relationSnapshot.docs) {
            backUpRelations.add(RelationFolderList.fromJson(m.data()));
          }
        }
        if (wordSnapshot.size > 0) {
          for (var m in wordSnapshot.docs) {
            final word = Word.fromJson(m.data());
            backUpWords.add(word.copyWithTranslation(
              meaning: targetLanguage != originLanguage
                  ? await _translateRepository.translate(
                      word.meaning,
                      targetLanguage,
                      sourceLanguge: originLanguage,
                    )
                  : null,
            ));
          }
        }
        if (grammarSnapshot.size > 0) {
          for (var m in grammarSnapshot.docs) {
            final grammar = GrammarPoint.fromJson(m.data());
            backUpGrammar.add(grammar.copyWithTranslation(
              definition: targetLanguage != originLanguage
                  ? await _translateRepository.translate(
                      grammar.definition,
                      targetLanguage,
                      sourceLanguge: originLanguage,
                    )
                  : null,
            ));
          }
        }
        if (listSnapshot.size > 0) {
          for (var m in listSnapshot.docs) {
            backUpList.add(WordList.fromJson(m.data()).copyWithReset());
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

        batch = _folderRepository.mergeFolders(
            batch, [backUpFolder], ConflictAlgorithm.ignore);

        /// Order matters as words depends on lists.
        /// Conflict algorithm allows us to ignore if the insertion if the list already exists.
        batch = _listRepository.mergeLists(
            batch, backUpList, ConflictAlgorithm.ignore);

        batch = _wordRepository.mergeWords(
            batch, backUpWords, ConflictAlgorithm.ignore);

        batch = _grammarPointRepository.mergeGrammarPoints(
            batch, backUpGrammar, ConflictAlgorithm.ignore);

        batch = _relationFolderListRepository.mergeRelationFolderList(
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
  Future<String> downloadListFromMarketPlace(
      String id, String targetLanguage) async {
    User? user = _auth.currentUser;
    await user?.reload();

    /// If the user is not authenticated, exit
    if (user == null) {
      return "market_need_auth".tr();
    } else {
      try {
        final marketSnapshot = await _ref.collection(collection).doc(id).get();

        /// Get sub collections for KanList and Word
        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(listLabel)
            .get();
        final wordSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(wordLabel)
            .get();
        final grammarSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(grammarLabel)
            .get();

        late WordList backUpList;
        List<Word> backUpWords = [];
        List<GrammarPoint> backUpGrammar = [];

        final originLanguage = marketSnapshot.get('language') as String;

        /// Apply the transform to the POJO
        if (listSnapshot.size > 0) {
          backUpList = WordList.fromJson(listSnapshot.docs[0].data());
          backUpList = backUpList.copyWithReset();
        }

        /// Check if the list is already installed
        final l = await _listRepository.getList(backUpList.name);
        if (l.name == backUpList.name) {
          return "market_download_already_installed".tr();
        }

        if (wordSnapshot.size > 0) {
          for (int x = 0; x < wordSnapshot.size; x++) {
            final word = Word.fromJson(wordSnapshot.docs[x].data());
            backUpWords.add(word.copyWithTranslation(
              meaning: targetLanguage != originLanguage
                  ? await _translateRepository.translate(
                      word.meaning,
                      targetLanguage,
                      sourceLanguge: originLanguage,
                    )
                  : null,
            ));
          }
        }

        if (grammarSnapshot.size > 0) {
          for (int x = 0; x < grammarSnapshot.size; x++) {
            final grammar =
                GrammarPoint.fromJson(grammarSnapshot.docs[x].data());
            backUpGrammar.add(grammar.copyWithTranslation(
              definition: targetLanguage != originLanguage
                  ? await _translateRepository.translate(
                      grammar.definition,
                      targetLanguage,
                      sourceLanguge: originLanguage,
                    )
                  : null,
            ));
          }
        }

        /// Update downloads on the list with a transaction
        final ref = _ref.collection(collection).doc(id);
        await _ref.runTransaction((transaction) async {
          transaction
              .update(ref, {Market.downloadField: FieldValue.increment(1)});
        });

        /// Merge it on the DB
        /// Order matters as words depends on lists.
        /// Conflict algorithm allows us to ignore if the insertion if the list already exists.
        Batch? batch = _database.batch();

        batch = _listRepository.mergeLists(
            batch, [backUpList], ConflictAlgorithm.ignore);

        batch = _wordRepository.mergeWords(
            batch, backUpWords, ConflictAlgorithm.ignore);

        batch = _grammarPointRepository.mergeGrammarPoints(
            batch, backUpGrammar, ConflictAlgorithm.ignore);

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

        var batch = _ref.batch();

        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(listLabel)
            .get();
        final wordSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(wordLabel)
            .get();
        final grammarSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(grammarLabel)
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

        batch.delete(folderSnapshot.docs.first.reference);
        writes++;

        for (var x in relationSnapshot.docs) {
          batch.delete((x.reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        for (var x in listSnapshot.docs) {
          batch.delete((x.reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        for (var x in wordSnapshot.docs) {
          batch.delete((x.reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        for (var x in grammarSnapshot.docs) {
          batch.delete((x.reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        batch.delete(market);
        writes++;
        batch = await _reinitializeBatch(batch);

        await batch.commit();
        writes = 0;
        return "";
      } catch (err) {
        print(err);
        writes = 0;
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

        var batch = _ref.batch();

        final listSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(listLabel)
            .get();
        final wordSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(wordLabel)
            .get();
        final grammarSnapshot = await _ref
            .collection(collection)
            .doc(id)
            .collection(grammarLabel)
            .get();

        for (var x = 0; x < listSnapshot.size; x++) {
          batch.delete((listSnapshot.docs[x].reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        for (var x = 0; x < wordSnapshot.size; x++) {
          batch.delete((wordSnapshot.docs[x].reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        for (var x = 0; x < grammarSnapshot.size; x++) {
          batch.delete((grammarSnapshot.docs[x].reference));
          writes++;
          batch = await _reinitializeBatch(batch);
        }
        batch.delete(market);
        writes++;
        batch = await _reinitializeBatch(batch);

        await batch.commit();
        writes = 0;
        return "";
      } catch (err) {
        print(err);
        writes = 0;
        return err.toString();
      }
    }
  }

  @override
  Future<int> uploadFolderToMarketPlace(
      String name,
      Folder folder,
      String language,
      List<WordList> lists,
      List<Word> words,
      List<GrammarPoint> grammarPoints,
      String description) async {
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

        /// Initialize Market, KanList and Words
        final Market market = Market(
          name: name,
          words: words.length,
          grammar: grammarPoints.length,
          uid: user.uid,
          author: user.displayName ?? "",
          description: description,
          uploadedToMarket: Utils.getCurrentMilliseconds(),
          isFolder: true,
          language: language,
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
        final List<Word> resetWords = [];
        for (var k in words) {
          resetWords.add(k.copyWithReset());
        }
        final List<GrammarPoint> resetGrammar = [];
        for (var gp in grammarPoints) {
          resetGrammar.add(gp.copyWithReset());
        }

        /// Market List
        batch.set(doc, market.toJson());
        writes++;

        /// Folder
        final DocumentReference k =
            doc.collection(folderLabel).doc(resetFolder.folder);
        batch.set(k, resetFolder.toJson());
        writes++;

        /// Relations Folder-KanList
        for (int x = 0; x < relations.length; x++) {
          final DocumentReference k =
              doc.collection(relationsKLLabel).doc(x.toString());
          batch.set(k, relations[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// KanList
        for (int x = 0; x < resetLists.length; x++) {
          final DocumentReference k =
              doc.collection(listLabel).doc(resetLists[x].name);
          batch.set(k, resetLists[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Word list
        for (int x = 0; x < resetWords.length; x++) {
          final DocumentReference k =
              doc.collection(wordLabel).doc(resetWords[x].word);
          batch.set(k, resetWords[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Grammar list
        for (int x = 0; x < resetGrammar.length; x++) {
          final DocumentReference k =
              doc.collection(grammarLabel).doc(resetGrammar[x].name);
          batch.set(k, resetGrammar[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        await batch.commit();
        writes = 0;
        return 0;
      } catch (err) {
        print(err);
        writes = 0;
        return -1;
      }
    }
  }

  @override
  Future<int> uploadListToMarketPlace(
      String name,
      WordList list,
      String language,
      List<Word> words,
      List<GrammarPoint> grammarPoints,
      String description) async {
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

        /// Initialize Market, KanList, Words and Grammar
        final Market resetList = Market(
          name: name,
          words: words.length,
          grammar: grammarPoints.length,
          uid: user.uid,
          author: user.displayName ?? "",
          description: description,
          uploadedToMarket: Utils.getCurrentMilliseconds(),
          language: language,
        ).copyWithKeywords();

        final WordList raw = list.copyWithReset();
        final List<Word> resetWords = [];
        for (var k in words) {
          resetWords.add(k.copyWithReset());
        }
        final List<GrammarPoint> resetGrammar = [];
        for (var gp in grammarPoints) {
          resetGrammar.add(gp.copyWithReset());
        }

        /// Market List
        batch.set(doc, resetList.toJson());
        writes++;

        /// KanList
        final DocumentReference k = doc.collection(listLabel).doc(raw.name);
        batch.set(k, raw.toJson());
        writes++;

        /// Word list
        for (int x = 0; x < resetWords.length; x++) {
          final DocumentReference k =
              doc.collection(wordLabel).doc(resetWords[x].word);
          batch.set(k, resetWords[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        /// Grammar list
        for (int x = 0; x < resetGrammar.length; x++) {
          final DocumentReference k =
              doc.collection(grammarLabel).doc(resetGrammar[x].name);
          batch.set(k, resetGrammar[x].toJson());
          writes++;
          batch = await _reinitializeBatch(batch);
        }

        await batch.commit();
        writes = 0;
        return 0;
      } catch (err) {
        print(err);
        writes = 0;
        return -1;
      }
    }
  }
}
