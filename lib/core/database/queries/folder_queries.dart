import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/types/folder_filters.dart';
import 'package:kanpractice/core/types/wordlist_filters.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqflite.dart';

class FolderQueries {
  Database? _database;

  FolderQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final FolderQueries _instance = FolderQueries._();

  /// Singleton instance of [FolderQueries]
  static FolderQueries get instance => _instance;

  /// Creates a [Folder] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createFolder(String name,
      {List<String> kanLists = const []}) async {
    if (_database != null) {
      try {
        if (name.trim().isEmpty) return -1;
        await _database?.insert(
            FolderTableFields.folderTable,
            Folder(
              folder: name,
              lastUpdated: Utils.getCurrentMilliseconds(),
            ).toJson());
        for (var l in kanLists) {
          int code = await moveKanListToFolder(name, l);
          if (code != 0) throw Exception();
        }
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Get specific [Folder] to show it on the UI
  Future<Folder> getFolder(String name) async {
    if (_database != null) {
      try {
        final res = await _database?.query(
          FolderTableFields.folderTable,
          where: "${FolderTableFields.nameField}=?",
          whereArgs: [name],
        );
        if (res != null) {
          return Folder.fromJson(res[0]);
        }
        return Folder.empty;
      } catch (err) {
        print(err.toString());
        return Folder.empty;
      }
    } else {
      return Folder.empty;
    }
  }

  /// Get all available [Folder] to show it on the UI
  Future<List<Folder>> getAllFolders({
    FolderFilters filter = FolderFilters.all,
    String order = "DESC",
    int? limit,
    int? offset,
  }) async {
    if (_database != null) {
      try {
        final res = await _database?.query(
          FolderTableFields.folderTable,
          orderBy: "${filter.filter} $order",
          limit: limit,
          offset: (offset != null && limit != null) ? offset * limit : null,
        );
        if (res != null) {
          return List.generate(res.length, (i) => Folder.fromJson(res[i]));
        }
        return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Get the full list of [WordList] related to a certain [Folder]. The pagination
  /// is perfomed within the list_queries.dart file.
  Future<List<WordList>> getAllListsOnFolder(
    String folder, {
    WordListFilters filter = WordListFilters.all,
    String order = "DESC",
    int? offset,
    int? limit,
  }) async {
    if (_database != null) {
      try {
        final limitParsed = limit != null ? "LIMIT $limit" : "";
        final offsetParsed =
            offset != null && limit != null ? "OFFSET ${offset * limit}" : "";
        final res = await _database?.rawQuery(
            "SELECT DISTINCT R.${ListTableFields.nameField}, "
            "R.${ListTableFields.totalWinRateWritingField}, "
            "R.${ListTableFields.totalWinRateReadingField}, "
            "R.${ListTableFields.totalWinRateRecognitionField}, "
            "R.${ListTableFields.totalWinRateListeningField}, "
            "R.${ListTableFields.totalWinRateSpeakingField}, "
            "R.${ListTableFields.lastUpdatedField} "
            "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
            "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
            "WHERE L.${RelationFolderListTableFields.nameField} LIKE '$folder' "
            "ORDER BY R.${filter.filter} $order "
            "$limitParsed $offsetParsed");
        if (res != null) {
          return List.generate(res.length, (i) => WordList.fromJson(res[i]));
        }
        return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Get the full list of [Kanji] related to a certain [Folder] from all [WordList]
  /// appearing on it. [mode], [type] and [category] serves as helper variables to
  /// order and query different words within the Folder to perform tests
  /// (Blitz, remembrance, less % and category).
  Future<List<Word>> getAllKanjiOnListsOnFolder(List<String> folders,
      {StudyModes? mode, Tests? type, int? category}) async {
    if (_database != null) {
      try {
        String whereClause = "";
        String query = "";

        /// Build up the where clauses from the listName
        for (var folder in folders) {
          whereClause +=
              "${RelationFolderListTableFields.nameField} LIKE '$folder' OR ";
        }

        /// Clean up the String
        whereClause = whereClause.substring(0, whereClause.length - 4);

        final joinSelection = "SELECT DISTINCT K.${WordTableFields.wordField}, "
            "K.${WordTableFields.listNameField}, "
            "K.${WordTableFields.meaningField}, "
            "K.${WordTableFields.pronunciationField}, "
            "K.${WordTableFields.winRateWritingField}, "
            "K.${WordTableFields.winRateReadingField}, "
            "K.${WordTableFields.winRateRecognitionField}, "
            "K.${WordTableFields.winRateListeningField}, "
            "K.${WordTableFields.winRateSpeakingField}, "
            "K.${WordTableFields.dateAddedField}, "
            "K.${WordTableFields.dateLastShown}, "
            "K.${WordTableFields.dateLastShownWriting}, "
            "K.${WordTableFields.dateLastShownReading}, "
            "K.${WordTableFields.dateLastShownRecognition}, "
            "K.${WordTableFields.dateLastShownListening}, "
            "K.${WordTableFields.dateLastShownSpeaking}, "
            "K.${WordTableFields.categoryField} "
            "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
            "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
            "JOIN ${WordTableFields.wordTable} K "
            "ON K.${WordTableFields.listNameField}=R.${ListTableFields.nameField} "
            "WHERE $whereClause";

        if (type == Tests.categories) {
          if (category != null) {
            query =
                "$joinSelection AND K.${WordTableFields.categoryField}=$category";
          } else {
            return [];
          }
        } else if (type == Tests.daily) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownWriting} ASC, "
                    "K.${WordTableFields.winRateWritingField} ASC";
                break;
              case StudyModes.reading:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownReading} ASC, "
                    "K.${WordTableFields.winRateReadingField} ASC";
                break;
              case StudyModes.recognition:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownRecognition} ASC, "
                    "K.${WordTableFields.winRateRecognitionField} ASC";
                break;
              case StudyModes.listening:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownListening} ASC, "
                    "K.${WordTableFields.winRateListeningField} ASC";
                break;
              case StudyModes.speaking:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownSpeaking} ASC, "
                    "K.${WordTableFields.winRateSpeakingField} ASC";
                break;
            }
          } else {
            return [];
          }
        } else if (type == Tests.time) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownWriting} ASC";
                break;
              case StudyModes.reading:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownReading} ASC";
                break;
              case StudyModes.recognition:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownRecognition} ASC";
                break;
              case StudyModes.listening:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownListening} ASC";
                break;
              case StudyModes.speaking:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.dateLastShownSpeaking} ASC";
                break;
            }
          } else {
            return [];
          }
        } else if (type == Tests.less) {
          if (mode != null) {
            switch (mode) {
              case StudyModes.writing:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.winRateWritingField} ASC";
                break;
              case StudyModes.reading:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.winRateReadingField} ASC";
                break;
              case StudyModes.recognition:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.winRateRecognitionField} ASC";
                break;
              case StudyModes.listening:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.winRateListeningField} ASC";
                break;
              case StudyModes.speaking:
                query =
                    "$joinSelection ORDER BY K.${WordTableFields.winRateSpeakingField} ASC";
                break;
            }
          } else {
            return [];
          }
        } else {
          query = joinSelection;
        }

        final res = await _database?.rawQuery(query);
        if (res != null) {
          return List.generate(res.length, (i) => Word.fromJson(res[i]));
        }
        return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Get the full list of [WordList] related to a certain [Folder] with a matching query.
  /// The pagination is perfomed within the list_queries.dart file.
  Future<List<WordList>> getAllListsOnFolderOnQuery(String query, String folder,
      {int? offset, int? limit}) async {
    if (_database != null) {
      try {
        final limitParsed = limit != null ? "LIMIT $limit" : "";
        final offsetParsed =
            offset != null && limit != null ? "OFFSET ${offset * limit}" : "";
        final res = await _database?.rawQuery(
            "SELECT DISTINCT R.${ListTableFields.nameField}, "
            "R.${ListTableFields.totalWinRateWritingField}, "
            "R.${ListTableFields.totalWinRateReadingField}, "
            "R.${ListTableFields.totalWinRateRecognitionField}, "
            "R.${ListTableFields.totalWinRateListeningField}, "
            "R.${ListTableFields.totalWinRateSpeakingField}, "
            "R.${ListTableFields.lastUpdatedField} "
            "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
            "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
            "JOIN ${WordTableFields.wordTable} K ON K.${WordTableFields.listNameField}=R.${ListTableFields.nameField} "
            "WHERE L.${RelationFolderListTableFields.nameField} LIKE '$folder' "
            "AND (R.${ListTableFields.nameField} LIKE '%$query%' OR K.${WordTableFields.meaningField} LIKE '%$query%' "
            "OR K.${WordTableFields.wordField} LIKE '%$query%' OR K.${WordTableFields.pronunciationField} LIKE '%$query%') "
            "ORDER BY ${ListTableFields.lastUpdatedField} DESC "
            "$limitParsed $offsetParsed");
        if (res != null) {
          return List.generate(res.length, (i) => WordList.fromJson(res[i]));
        }
        return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Query to get all [Folder] from the db based on a [query] that will match: folder name.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<Folder>> getListsMatchingQuery(String query,
      {required int offset, required int limit}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database
            ?.rawQuery("SELECT * FROM ${FolderTableFields.folderTable} "
                "WHERE ${FolderTableFields.nameField} LIKE '%$query%' "
                "ORDER BY ${FolderTableFields.lastUpdatedField} DESC "
                "LIMIT $limit OFFSET ${offset * limit}");
        if (res != null) {
          return List.generate(res.length, (i) => Folder.fromJson(res![i]));
        } else {
          return [];
        }
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Add the relation between a [KanList] and a [Folder]
  Future<int> moveKanListToFolder(String folder, String list) async {
    if (_database != null) {
      try {
        await _database?.insert(
          RelationFolderListTableFields.relTable,
          RelationFolderList(folder: folder, list: list).toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Removes the relation between a [KanList] and a [Folder]
  Future<int> removeKanListToFolder(String folder, String list) async {
    if (_database != null) {
      try {
        await _database?.delete(
          RelationFolderListTableFields.relTable,
          where:
              "${RelationFolderListTableFields.listNameField}=? AND ${RelationFolderListTableFields.nameField}=?",
          whereArgs: [list, folder],
        );
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Get all available relations [Folder]-[RelationFolderList] for backup purposes
  Future<List<RelationFolderList>> getFolderRelation() async {
    if (_database != null) {
      try {
        final res =
            await _database?.query(RelationFolderListTableFields.relTable);
        if (res != null) {
          return List.generate(
              res.length, (i) => RelationFolderList.fromJson(res[i]));
        }
        return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else {
      return [];
    }
  }

  /// Gets a [Folder] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeFolder(String folder) async {
    if (_database != null) {
      try {
        await _database?.delete(FolderTableFields.folderTable,
            where: "${FolderTableFields.nameField}=?", whereArgs: [folder]);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }
}
