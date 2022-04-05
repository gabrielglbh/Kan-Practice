import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:sqflite/sqflite.dart';

class InitialQueries {
  Database? _database;

  InitialQueries._() {
    _database = CustomDatabase.instance.database;
  }

  static final InitialQueries _instance = InitialQueries._();

  /// Singleton instance of [InitialQueries]
  static InitialQueries get instance => _instance;

  /// Sets the initial KanLists on first app view. The initial KanLists
  /// and their words are extracted from: assets/initialData/en.json
  Future<int> setInitialDataForReference(BuildContext context) async {
    if (_database != null) {
      try {
        final String currentLocale = EasyLocalization.of(context)?.locale.languageCode ?? "en";
        final String initialKanLists = await rootBundle.loadString("assets/initialData/$currentLocale.json");
        final Map<String, dynamic> kanLists = jsonDecode(initialKanLists);
        final List<dynamic> listsNonCasted = kanLists["Lists"];
        final List<dynamic> kanjiNonCasted = kanLists["Kanji"];
        final List<KanjiList> lists = [];
        final List<Kanji> kanji = [];

        /// Cast the JSON to the proper type
        listsNonCasted.forEach((item) => lists.add(KanjiList.fromJson(item)));
        kanjiNonCasted.forEach((item) => kanji.add(Kanji.fromJson(item)));

        /// Order matters as kanji depends on lists.
        final batch = _database?.batch();

        /// For all KanLists and Kanji, set the last updated field to current time
        for (int x = 0; x < lists.length; x++) {
          final KanjiList k = lists[x].copyWithUpdatedDate(lastUpdated: GeneralUtils.getCurrentMilliseconds());
          batch?.insert(KanListTableFields.listsTable, k.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
        for (int x = 0; x < kanji.length; x++) {
          final Kanji k = kanji[x].copyWithUpdatedDate(
            dateAdded: GeneralUtils.getCurrentMilliseconds(),
            dateLastShown: GeneralUtils.getCurrentMilliseconds()
          );
          batch?.insert(KanjiTableFields.kanjiTable, k.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }

        final results = await batch?.commit();
        return results?.length == 0 ? -3 : 0;
      } catch (err) {
        return -2;
      }
    } else return -1;
  }
}