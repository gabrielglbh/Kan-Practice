import 'package:kanpractice/core/types/wordlist_filters.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IListRepository {
  /// Creates a [WordList] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createList(String name);

  /// Merges lists from the backup
  Future<Batch?> mergeLists(
    Batch? batch,
    List<WordList> lists,
    ConflictAlgorithm conflictAlgorithm,
  ); // TODO: Conflict - Replace on backup,  Ignore on market merge
  Future<WordList> getList(String name);

  /// Gets a [WordList] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeList(String name);

  /// Creates a [WordList] and updates it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateList(String name, Map<String, dynamic> fields);
  Future<List<WordList>> getAllLists({
    WordListFilters filter = WordListFilters.all,
    String order = "DESC",
    int? limit,
    int? offset,
  });
  Future<int> getTotalListCount();

  /// Query the [WordList] with the best scoring overall and the worst one.
  /// Returns the name of the list: FIRST -> best , SECOND -> worst
  Future<List<String>> getBestAndWorstList();
  Future<List<WordList>> getListsMatchingQuery(
    String query, {
    required int offset,
    required int limit,
  });
}
