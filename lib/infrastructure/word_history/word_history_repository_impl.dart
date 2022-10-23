import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/domain/word_history/i_word_history_repository.dart';
import 'package:kanpractice/domain/word_history/word_history.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: IWordHistoryRepository)
class WordHistoryRepositoryImpl implements IWordHistoryRepository {
  final Database _database;

  WordHistoryRepositoryImpl(this._database);

  @override
  Future<int> addWordToHistory(String word) async {
    try {
      await _database.insert(
          WordHistoryFields.historyTable,
          WordHistory(
            word: word,
            searchedOn: Utils.getCurrentMilliseconds(),
          ).toJson());
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<List<WordHistory>> getHistory(int offset,
      {int limit = LazyLoadingLimits.wordHistory}) async {
    try {
      List<Map<String, dynamic>>? res = await _database
          .rawQuery("SELECT * FROM ${WordHistoryFields.historyTable} "
              "ORDER BY ${WordHistoryFields.searchedOnField} DESC "
              "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => WordHistory.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<int> removeAll() async {
    try {
      await _database.delete(WordHistoryFields.historyTable);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
