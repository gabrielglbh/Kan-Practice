import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: IGrammarPointRepository)
class GrammarPointRepositoryImpl implements IGrammarPointRepository {
  final Database _database;
  final IPreferencesRepository _preferencesRepository;

  GrammarPointRepositoryImpl(this._database, this._preferencesRepository);

  @override
  Future<int> createGrammarPoint(GrammarPoint grammarPoint) async {
    try {
      await _database.insert(
          GrammarTableFields.grammarTable, grammarPoint.toJson());
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<List<GrammarPoint>> getAllGrammarPoints(
      {StudyModes? mode, Tests? type}) {
    // TODO: implement getAllGrammarPoints
    throw UnimplementedError();
  }

  @override
  Future<List<GrammarPoint>> getAllGrammarPointsForPractice(
      String listName, StudyModes mode) {
    // TODO: implement getAllGrammarPointsForPractice
    throw UnimplementedError();
  }

  @override
  Future<List<GrammarPoint>> getAllGrammarPointsFromList(String listName,
      {int? offset, int? limit}) async {
    try {
      List<Map<String, dynamic>> res = await _database.query(
          GrammarTableFields.grammarTable,
          where: "${GrammarTableFields.listNameField}=?",
          whereArgs: [listName],
          orderBy: "${GrammarTableFields.dateAddedField} ASC",
          limit: limit,
          offset: (offset != null && limit != null) ? (offset * limit) : null);
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<GrammarPoint>> getDailySM2GrammarPoints(StudyModes mode) {
    // TODO: implement getDailySM2GrammarPoints
    throw UnimplementedError();
  }

  @override
  Future<GrammarPoint> getGrammarPoint(
      String listName, String grammarPoint) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(GrammarTableFields.grammarTable,
          where:
              "${GrammarTableFields.listNameField}=? AND ${GrammarTableFields.nameField}=?",
          whereArgs: [listName, grammarPoint]);
      return GrammarPoint.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return GrammarPoint.empty;
    }
  }

  @override
  Future<List<GrammarPoint>> getGrammarPointBasedOnSelectedLists(
      List<String> listNames) {
    // TODO: implement getGrammarPointBasedOnSelectedLists
    throw UnimplementedError();
  }

  @override
  Future<List<GrammarPoint>> getGrammarPointsMatchingQuery(
      String query, String listName,
      {required int offset, required int limit}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.rawQuery("SELECT * "
          "FROM ${GrammarTableFields.grammarTable} "
          "WHERE ${GrammarTableFields.listNameField} = '$listName' "
          "AND (${GrammarTableFields.nameField} LIKE '%$query%' "
          "OR ${GrammarTableFields.definitionField} LIKE '%$query%' "
          "OR ${GrammarTableFields.exampleField} LIKE '%$query%') "
          "ORDER BY ${GrammarTableFields.dateAddedField} ASC "
          "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<int>> getSM2ReviewGrammarPointsAsForToday() {
    // TODO: implement getSM2ReviewGrammarPointsAsForToday
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalGrammarPointCount() {
    // TODO: implement getTotalGrammarPointCount
    throw UnimplementedError();
  }

  @override
  Future<GrammarPoint> getTotalGrammarPointsWinRates() {
    // TODO: implement getTotalGrammarPointsWinRates
    throw UnimplementedError();
  }

  @override
  Future<Batch?> mergeGrammarPoints(Batch? batch,
      List<GrammarPoint> grammarPoints, ConflictAlgorithm conflictAlgorithm) {
    // TODO: implement mergeGrammarPoints
    throw UnimplementedError();
  }

  @override
  Future<int> removeGrammarPoint(String listName, String grammarPoint) async {
    try {
      await _database.delete(GrammarTableFields.grammarTable,
          where:
              "${GrammarTableFields.listNameField}=? AND ${GrammarTableFields.nameField}=?",
          whereArgs: [listName, grammarPoint]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<int> updateGrammarPoint(
      String listName, String grammarPoint, Map<String, dynamic> fields) async {
    try {
      await _database.update(GrammarTableFields.grammarTable, fields,
          where:
              "${GrammarTableFields.listNameField}=? AND ${GrammarTableFields.nameField}=?",
          whereArgs: [listName, grammarPoint]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
