import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/wordlist_filters.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IListRepository)
class ListRepositoryImpl implements IListRepository {
  final Database _database;

  ListRepositoryImpl(this._database);

  @override
  Future<int> createList(String name) async {
    try {
      if (name.trim().isEmpty) return -1;
      await _database.insert(
          ListTableFields.listsTable,
          WordList(name: name, lastUpdated: Utils.getCurrentMilliseconds())
              .toJson());
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<List<WordList>> getAllLists(
      {WordListFilters filter = WordListFilters.all,
      String order = "DESC",
      int? limit,
      int? offset}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(ListTableFields.listsTable,
          orderBy: "${filter.filter} $order",
          limit: limit,
          offset: (offset != null && limit != null) ? offset * limit : null);
      return List.generate(res.length, (i) => WordList.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<String>> getBestAndWorstList() async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(ListTableFields.listsTable);
      final List<WordList> l =
          List.generate(res.length, (i) => WordList.fromJson(res![i]));
      List<String> listNames = [];
      List<double> listAcc = [];
      for (var list in l) {
        listNames.add(list.name);
        final double acc = list.totalWinRateWriting +
            list.totalWinRateReading +
            list.totalWinRateRecognition +
            list.totalWinRateListening;
        listAcc.add((acc <= 0 ? 0 : acc) / StudyModes.values.length);
      }
      final double best =
          listAcc.reduce((curr, next) => curr > next ? curr : next);
      final double worst =
          listAcc.reduce((curr, next) => curr < next ? curr : next);
      return [
        listNames[listAcc.indexOf(best)],
        listNames[listAcc.indexOf(worst)]
      ];
    } catch (err) {
      print(err.toString());
      return ["", ""];
    }
  }

  @override
  Future<WordList> getList(String name) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(ListTableFields.listsTable,
          where: "${WordTableFields.listNameField}=?", whereArgs: [name]);
      return WordList.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return WordList.empty;
    }
  }

  @override
  Future<List<WordList>> getListsMatchingQuery(String query,
      {required int offset, required int limit}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.rawQuery(
          "SELECT DISTINCT L.${ListTableFields.nameField}, "
          "L.${ListTableFields.totalWinRateWritingField}, "
          "L.${ListTableFields.totalWinRateReadingField}, "
          "L.${ListTableFields.totalWinRateRecognitionField}, "
          "L.${ListTableFields.totalWinRateListeningField}, "
          "L.${ListTableFields.totalWinRateSpeakingField}, "
          "L.${ListTableFields.lastUpdatedField} "
          "FROM ${ListTableFields.listsTable} L JOIN ${WordTableFields.wordTable} K "
          "ON K.${WordTableFields.listNameField}=L.${ListTableFields.nameField} "
          "WHERE L.${ListTableFields.nameField} LIKE '%$query%' OR K.${WordTableFields.meaningField} LIKE '%$query%' "
          "OR K.${WordTableFields.wordField} LIKE '%$query%' OR K.${WordTableFields.pronunciationField} LIKE '%$query%' "
          "ORDER BY ${ListTableFields.lastUpdatedField} DESC "
          "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => WordList.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<int> getTotalListCount() async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(ListTableFields.listsTable);
      return res.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  @override
  Future<Batch?> mergeLists(Batch? batch, List<WordList> lists,
      ConflictAlgorithm conflictAlgorithm) async {
    for (int x = 0; x < lists.length; x++) {
      batch?.insert(ListTableFields.listsTable, lists[x].toJson(),
          conflictAlgorithm: conflictAlgorithm);
    }
    return batch;
  }

  @override
  Future<int> removeList(String name) async {
    try {
      await _database.delete(ListTableFields.listsTable,
          where: "${WordTableFields.listNameField}=?", whereArgs: [name]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<int> updateList(String name, Map<String, dynamic> fields) async {
    try {
      await _database.update(ListTableFields.listsTable, fields,
          where: "${WordTableFields.listNameField}=?", whereArgs: [name]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
