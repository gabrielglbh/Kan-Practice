import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IGrammarPointRepository {
  /// Creates a [GrammarPoint] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createGrammarPoint(GrammarPoint grammarPoint);

  /// Merges grammars from the backup or market
  Batch? mergeGrammarPoints(
    Batch? batch,
    List<GrammarPoint> grammarPoints,
    ConflictAlgorithm conflictAlgorithm,
  );
  Future<GrammarPoint> getGrammarPoint(String grammarPoint,
      {String? listName, String? definition});

  /// Gets a [GrammarPoint] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeGrammarPoint(String listName, String grammarPoint);

  /// Gets a [GrammarPoint] and updates it on the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateGrammarPoint(
    String listName,
    String grammarPoint,
    Map<String, dynamic> fields,
  );
  Future<List<GrammarPoint>> getDailySM2GrammarPoints(GrammarModes mode);

  /// Query to get all Grammar available in the current db. If anything goes wrong,
  /// an empty list will be returned.
  ///
  /// [mode] is a nullable parameter that serves as a control variable to
  /// query all Grammar by their last shown date based on the study mode to be
  /// studied. If null, all Grammar will be retrieved.
  ///
  /// [type] serves as a control variable to order all the Grammar by
  /// their last shown parameter or worst accuracy parameter. See [Tests].
  Future<List<GrammarPoint>> getAllGrammarPoints(
      {GrammarModes? mode, Tests? type});
  Future<List<GrammarPoint>> getArchiveGrammarPoints({
    int? offset,
    int? limit,
  });
  Future<List<GrammarPoint>> getGrammarPointBasedOnSelectedLists(
      List<String> listNames);
  Future<List<GrammarPoint>> getAllGrammarPointsFromList(
    String listName, {
    int? offset,
    int? limit,
  });
  Future<List<GrammarPoint>> getGrammarPointsMatchingQuery(
    String query, {
    String? listName,
    required int offset,
    required int limit,
  });
  Future<int> getTotalGrammarPointCount();
  Future<GrammarPoint> getTotalGrammarPointsWinRates();
  Future<List<int>> getSM2ReviewGrammarPointsAsForToday();
}
