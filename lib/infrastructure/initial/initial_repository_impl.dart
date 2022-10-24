import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/domain/initial/i_initial_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IInitialRepository)
class InitialRepositoryImpl implements IInitialRepository {
  final Database _database;

  InitialRepositoryImpl(this._database);

  @override
  Future<int> setInitialDataForReference(BuildContext context) async {
    try {
      final String currentLocale =
          EasyLocalization.of(context)?.locale.languageCode ?? "en";
      final String initialKanLists =
          await rootBundle.loadString("assets/initialData/$currentLocale.json");
      final Map<String, dynamic> kanLists = jsonDecode(initialKanLists);
      final List<dynamic> listsNonCasted = kanLists["Lists"];
      final List<dynamic> kanjiNonCasted = kanLists["Kanji"];
      final List<WordList> lists = [];
      final List<Word> kanji = [];

      /// Cast the JSON to the proper type
      for (var item in listsNonCasted) {
        lists.add(WordList.fromJson(item));
      }
      for (var item in kanjiNonCasted) {
        kanji.add(Word.fromJson(item));
      }

      /// Order matters as kanji depends on lists.
      final batch = _database.batch();

      /// For all KanLists and Kanji, set the last updated field to current time
      for (int x = 0; x < lists.length; x++) {
        final WordList k = lists[x]
            .copyWithUpdatedDate(lastUpdated: Utils.getCurrentMilliseconds());
        batch.insert(ListTableFields.listsTable, k.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      for (int x = 0; x < kanji.length; x++) {
        final Word k = kanji[x].copyWithUpdatedDate(
            dateAdded: Utils.getCurrentMilliseconds(),
            dateLastShown: Utils.getCurrentMilliseconds());
        batch.insert(WordTableFields.wordTable, k.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      final results = await batch.commit();
      return results.isEmpty == true ? -3 : 0;
    } catch (err) {
      return -2;
    }
  }
}