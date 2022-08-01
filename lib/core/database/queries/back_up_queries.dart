import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/migration_utils.dart';
import 'package:kanpractice/core/database/models/folder.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/models/rel_folder_kanlist.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_localization/easy_localization.dart';

class BackUpQueries {
  Database? _database;

  BackUpQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final BackUpQueries _instance = BackUpQueries._();

  /// Singleton instance of [BackUpQueries]
  static BackUpQueries get instance => _instance;

  /// Merges the back up from Firebase to the local database.
  /// It takes as parameter [kanji], [lists], [folders], [tests] and relations to be MERGED into the
  /// local db.
  Future<String> mergeBackUp(
    List<Kanji> kanji,
    List<KanjiList> lists,
    List<Folder> folders,
    List<Test> tests,
    List<RelFolderKanList> relFolderKanList,
  ) async {
    if (_database != null) {
      try {
        /// Order matters as kanji depends on lists.
        /// Conflict algorithm allows us to merge the data from back up with current one.
        final batch = _database?.batch();
        final utils = MigrationUtils();

        for (int x = 0; x < lists.length; x++) {
          batch?.insert(KanListTableFields.listsTable, lists[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        for (int x = 0; x < kanji.length; x++) {
          batch?.insert(KanjiTableFields.kanjiTable, kanji[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);

          /// If the backup has no dateLastShown set up, fill dateLastShown with dateAdded
          if (kanji[x].dateLastShown == 0) {
            utils.batchUpdateDateLastShown(batch, kanji[x]);
          }
        }

        for (int x = 0; x < folders.length; x++) {
          batch?.insert(FolderTableFields.folderTable, folders[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        /// Tests can be dismissed, checking if the test array has something
        if (tests.isNotEmpty) {
          for (int x = 0; x < tests.length; x++) {
            batch?.insert(TestTableFields.testTable, tests[x].toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace);
            if (tests[x].testMode == -1) {
              utils.batchUpdateTestMode(batch, tests[x]);
            }
          }
        }

        for (int x = 0; x < relFolderKanList.length; x++) {
          batch?.insert(KanListFolderRelationTableFields.relTable,
              relFolderKanList[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        final results = await batch?.commit();
        return results?.isEmpty == true
            ? "backup_queries_mergeBackUp_failed".tr()
            : "";
      } catch (err) {
        return err.toString();
      }
    } else {
      return "backup_queries_mergeBackUp_catch".tr();
    }
  }
}
