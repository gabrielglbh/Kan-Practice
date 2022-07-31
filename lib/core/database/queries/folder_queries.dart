import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/folder.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/models/rel_folder_kanlist.dart';
import 'package:kanpractice/core/types/folder_filters.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/ui/general_utils.dart';
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
              lastUpdated: GeneralUtils.getCurrentMilliseconds(),
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

  // TODO: Not working
  /// Get the full list of [KanjiList] related to a certain [Folder]. The pagination
  /// is perfomed within the list_queries.dart file.
  Future<List<KanjiList>> getAllListsOnFolder(
    String folder, {
    KanListFilters filter = KanListFilters.all,
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
            "SELECT DISTINCT R.${KanListTableFields.nameField}, "
            "R.${KanListTableFields.totalWinRateWritingField}, "
            "R.${KanListTableFields.totalWinRateReadingField}, "
            "R.${KanListTableFields.totalWinRateRecognitionField}, "
            "R.${KanListTableFields.totalWinRateListeningField}, "
            "R.${KanListTableFields.lastUpdatedField} "
            "FROM ${KanListFolderRelationTableFields.relTable} L JOIN ${KanListTableFields.listsTable} R "
            "ON L.${KanListFolderRelationTableFields.kanListNameField}=R.${KanListTableFields.nameField} "
            "WHERE L.${KanListFolderRelationTableFields.nameField} LIKE $folder "
            "ORDER BY R.${filter.filter} $order "
            "$limitParsed $offsetParsed");
        if (res != null) {
          return List.generate(res.length, (i) => KanjiList.fromJson(res[i]));
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

  /// Get the full list of [KanjiList] related to a certain [Folder] with a matching query.
  /// The pagination is perfomed within the list_queries.dart file.
  Future<List<KanjiList>> getAllListsOnFolderOnQuery(
      String query, String folder,
      {int? offset, int? limit}) async {
    if (_database != null) {
      try {
        final limitParsed = limit != null ? "LIMIT $limit" : "";
        final offsetParsed =
            offset != null && limit != null ? "OFFSET ${offset * limit}" : "";
        final res = await _database?.rawQuery(
            "SELECT DISTINCT R.${KanListTableFields.nameField}, "
            "R.${KanListTableFields.totalWinRateWritingField}, "
            "R.${KanListTableFields.totalWinRateReadingField}, "
            "R.${KanListTableFields.totalWinRateRecognitionField}, "
            "R.${KanListTableFields.totalWinRateListeningField}, "
            "R.${KanListTableFields.lastUpdatedField} "
            "FROM ${KanListFolderRelationTableFields.relTable} L JOIN ${KanListTableFields.listsTable} R "
            "ON L.${KanListFolderRelationTableFields.kanListNameField}=R.${KanListTableFields.nameField} "
            "JOIN ${KanjiTableFields.kanjiTable} K ON K.${KanjiTableFields.listNameField}=R.${KanListTableFields.nameField}"
            "WHERE L.${KanListFolderRelationTableFields.nameField} LIKE $folder "
            "AND (R.${KanListTableFields.nameField} LIKE '%$query%' OR K.${KanjiTableFields.meaningField} LIKE '%$query%' "
            "OR K.${KanjiTableFields.kanjiField} LIKE '%$query%' OR K.${KanjiTableFields.pronunciationField} LIKE '%$query%') "
            "ORDER BY ${KanListTableFields.lastUpdatedField} DESC "
            "$limitParsed $offsetParsed");
        if (res != null) {
          return List.generate(res.length, (i) => KanjiList.fromJson(res[i]));
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
        await _database?.insert(KanListFolderRelationTableFields.relTable,
            RelFolderKanList(folder: folder, kanListName: list).toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else {
      return -2;
    }
  }

  /// Get all available relations [Folder]-[RelFolderKanList] for backup purposes
  Future<List<RelFolderKanList>> getFolderRelation() async {
    if (_database != null) {
      try {
        final res =
            await _database?.query(KanListFolderRelationTableFields.relTable);
        if (res != null) {
          return List.generate(
              res.length, (i) => RelFolderKanList.fromJson(res[i]));
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
