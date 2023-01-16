import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/initial/i_initial_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IInitialRepository)
class InitialRepositoryImpl implements IInitialRepository {
  final Database _database;
  final IListRepository _listRepository;
  final IWordRepository _wordRepository;

  InitialRepositoryImpl(
    this._database,
    this._listRepository,
    this._wordRepository,
  );

  @override
  Future<int> setInitialDataForReference(BuildContext context) async {
    try {
      final String currentLocale =
          EasyLocalization.of(context)?.locale.languageCode ?? "en";
      final String initialKanLists =
          await rootBundle.loadString("assets/initialData/$currentLocale.json");
      final Map<String, dynamic> kanLists = jsonDecode(initialKanLists);
      final List<dynamic> listsNonCasted = kanLists["Lists"];
      final List<dynamic> wordsNonCasted = kanLists["Kanji"];
      final List<WordList> lists = [];
      final List<Word> words = [];

      /// Cast the JSON to the proper type
      for (var item in listsNonCasted) {
        lists.add(WordList.fromJson(item));
      }
      for (var item in wordsNonCasted) {
        words.add(Word.fromJson(item));
      }

      /// Order matters as words depends on lists.
      Batch? batch = _database.batch();

      /// For all KanLists and Word, set the last updated field to current time
      for (int x = 0; x < lists.length; x++) {
        final WordList k = lists[x]
            .copyWithUpdatedDate(lastUpdated: Utils.getCurrentMilliseconds());
        batch =
            _listRepository.mergeLists(batch, [k], ConflictAlgorithm.replace);
      }
      for (int x = 0; x < words.length; x++) {
        final Word k = words[x].copyWithUpdatedDate(
            dateAdded: Utils.getCurrentMilliseconds(),
            dateLastShown: Utils.getCurrentMilliseconds());
        batch =
            _wordRepository.mergeWords(batch, [k], ConflictAlgorithm.replace);
      }

      final results = await batch?.commit();
      return results?.isEmpty == true ? -3 : 0;
    } catch (err) {
      return -2;
    }
  }
}
