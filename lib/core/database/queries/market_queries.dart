import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:sqflite/sqlite_api.dart';

class MarketQueries {
  Database? _database;

  MarketQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final MarketQueries _instance = MarketQueries._();

  /// Singleton instance of [MarketQueries]
  static MarketQueries get instance => _instance;

  /// Installs the list from the market into the user's private DB.
  /// It uses IGNORE conflict algorithm: if the List or Kanji exists already, it will
  /// ignore the insertion and commence the next one.
  Future<String> mergeMarketListIntoDb(
      KanjiList list, List<Kanji> kanji) async {
    if (_database != null) {
      try {
        /// Check if the list is already installed
        final l = await ListQueries.instance.getList(list.name);
        if (l.name == list.name) {
          return "market_download_already_installed".tr();
        } else {
          /// Order matters as kanji depends on lists.
          /// Conflict algorithm allows us to ignore if the insertion if the list already exists.
          final batch = _database?.batch();
          batch?.insert(KanListTableFields.listsTable, list.toJson(),
              conflictAlgorithm: ConflictAlgorithm.ignore);

          for (int x = 0; x < kanji.length; x++) {
            batch?.insert(KanjiTableFields.kanjiTable, kanji[x].toJson(),
                conflictAlgorithm: ConflictAlgorithm.ignore);
          }

          final results = await batch?.commit();
          return results?.isEmpty == true
              ? "backup_queries_mergeBackUp_failed".tr()
              : "";
        }
      } catch (err) {
        return err.toString();
      }
    } else {
      return "backup_queries_mergeBackUp_catch".tr();
    }
  }
}
