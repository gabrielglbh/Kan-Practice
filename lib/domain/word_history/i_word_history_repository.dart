import 'package:kanpractice/domain/word_history/word_history.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

abstract class IWordHistoryRepository {
  /// Creates a [WordHistory] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> addWordToHistory(String word);

  /// Removes all history.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> removeAll();
  Future<List<WordHistory>> getHistory(
    int offset, {
    int limit = LazyLoadingLimits.wordHistory,
  });
}
