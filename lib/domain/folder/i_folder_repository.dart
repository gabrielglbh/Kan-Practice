import 'package:kanpractice/core/types/folder_filters.dart';
import 'package:kanpractice/core/types/wordlist_filters.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IFolderRepository {
  /// Creates a [Folder] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createFolder(String name, {List<String> lists = const []});

  /// Merges words from the backup
  Future<int> mergeFolders(
    List<Folder> folders,
    ConflictAlgorithm conflictAlgorithm,
  ); // TODO: Conlict - replace on backup, ignore on market
  Future<Folder> getFolder(String name);
  Future<List<Folder>> getAllFolders({
    FolderFilters filter = FolderFilters.all,
    String order = "DESC",
    int? limit,
    int? offset,
  });
  Future<List<WordList>> getAllListsOnFolder(
    String folder, {
    WordListFilters filter = WordListFilters.all,
    String order = "DESC",
    int? offset,
    int? limit,
  });

  /// Get the full list of [Word] related to a certain [Folder] from all [WordList]
  /// appearing on it. [mode], [type] and [category] serves as helper variables to
  /// order and query different words within the Folder to perform tests
  /// (Blitz, remembrance, less % and category).
  Future<List<Word>> getAllWordsOnListsOnFolder(
    List<String> folders, {
    StudyModes? mode,
    Tests? type,
    int? category,
  });
  Future<List<WordList>> getAllListsOnFolderOnQuery(
    String query,
    String folder, {
    int? offset,
    int? limit,
  });
  Future<List<Folder>> getListsMatchingQuery(
    String query, {
    required int offset,
    required int limit,
  });
  Future<int> moveListToFolder(String folder, String list);
  Future<int> removeListOfFolder(String folder, String list);

  /// Gets a [Folder] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeFolder(String folder);
}
