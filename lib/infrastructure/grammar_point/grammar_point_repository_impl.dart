import 'package:injectable/injectable.dart';
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
  Future<int> createGrammarPoint(GrammarPoint grammarPoint) {
    // TODO: implement createGrammarPoint
    throw UnimplementedError();
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
      {int? offset, int? limit}) {
    // TODO: implement getAllGrammarPointsFromList
    throw UnimplementedError();
  }

  @override
  Future<List<GrammarPoint>> getDailySM2GrammarPoints(StudyModes mode) {
    // TODO: implement getDailySM2GrammarPoints
    throw UnimplementedError();
  }

  @override
  Future<GrammarPoint> getGrammarPoint(String listName, String grammarPoint) {
    // TODO: implement getGrammarPoint
    throw UnimplementedError();
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
      {required int offset, required int limit}) {
    // TODO: implement getGrammarPointsMatchingQuery
    throw UnimplementedError();
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
  Future<int> removeGrammarPoint(String listName, String grammarPoint) {
    // TODO: implement removeGrammarPoint
    throw UnimplementedError();
  }

  @override
  Future<int> updateGrammarPoint(
      String listName, String grammarPoint, Map<String, dynamic> fields) {
    // TODO: implement updateGrammarPoint
    throw UnimplementedError();
  }
}
