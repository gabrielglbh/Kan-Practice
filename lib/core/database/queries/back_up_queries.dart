import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/migration_utils.dart';
import 'package:kanpractice/core/firebase/models/backup.dart';
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
  Future<String> mergeBackUp(BackUp bu) async {
    if (_database != null) {
      try {
        /// Order matters as kanji depends on lists.
        /// Conflict algorithm allows us to merge the data from back up with current one.
        final batch = _database?.batch();
        final utils = MigrationUtils();

        for (int x = 0; x < bu.lists.length; x++) {
          batch?.insert(KanListTableFields.listsTable, bu.lists[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        for (int x = 0; x < bu.kanji.length; x++) {
          batch?.insert(KanjiTableFields.kanjiTable, bu.kanji[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);

          /// If the backup has no dateLastShown set up, fill dateLastShown with dateAdded
          if (bu.kanji[x].dateLastShown == 0) {
            utils.batchUpdateDateLastShown(batch, bu.kanji[x]);
          }
        }

        for (int x = 0; x < bu.folders.length; x++) {
          batch?.insert(FolderTableFields.folderTable, bu.folders[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        batch?.insert(TestDataTableFields.testDataTable, bu.testData.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);

        for (int x = 0; x < bu.relFolderKanList.length; x++) {
          batch?.insert(KanListFolderRelationTableFields.relTable,
              bu.relFolderKanList[x].toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        for (int x = 0; x < bu.testSpecData.length; x++) {
          batch?.insert(TestSpecificDataTableFields.testDataTable,
              bu.testSpecData[x].toJson(),
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
