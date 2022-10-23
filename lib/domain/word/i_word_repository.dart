import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IWordRepository {
  /// Creates a [Word] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createWord(Word word);

  /// Merges words from the backup or market
  Future<Batch?> mergeWords(
    Batch? batch,
    List<Word> words,
    ConflictAlgorithm conflictAlgorithm,
  ); // TODO: Replace on backup and ignore on market
  Future<Word> getWord(String listName, String word);

  /// Gets a [Word] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeWord(String listName, String word);

  /// Gets a [Word] and updates it on the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateWord(
    String listName,
    String word,
    Map<String, dynamic> fields,
  );
  Future<List<Word>> getDailyWords(StudyModes mode);

  /// Query to get all Word available in the current db. If anything goes wrong,
  /// an empty list will be returned.
  ///
  /// [mode] is a nullable parameter that serves as a control variable to
  /// query all Word by their last shown date based on the study mode to be
  /// studied. If null, all Word will be retrieved.
  ///
  /// [type] serves as a control variable to order all the Word by
  /// their last shown parameter or worst accuracy parameter. See [Tests].
  Future<List<Word>> getAllWords({StudyModes? mode, Tests? type});
  Future<List<Word>> getWordBasedOnSelectedLists(List<String> listNames);
  Future<List<Word>> getWordsBasedOnCategory(int category);
  Future<List<Word>> getAllWordsFromList(
    String listName, {
    int? offset,
    int? limit,
  });
  Future<List<Word>> getWordsMatchingQuery(
    String query,
    String listName, {
    required int offset,
    required int limit,
  });

  /// Query to get all Word available in the current db within a list with the name [listName]
  /// that enables Spatial Learning: ordering in ASC order the [Word] with less winRate.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Word>> getAllWordsForPractice(String listName, StudyModes mode);
  Future<int> getTotalWordCount();
  Future<Word> getTotalWordsWinRates();
  Future<List<int>> getWordsFromCategory();
}
