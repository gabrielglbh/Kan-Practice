import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
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
      {GrammarModes? mode, Tests? type}) async {
    try {
      String query = "";
      if (type == Tests.time) {
        if (mode != null) {
          switch (mode) {
            case GrammarModes.definition:
              query = "SELECT * FROM ${GrammarTableFields.grammarTable} "
                  "ORDER BY ${GrammarTableFields.dateLastShownDefinitionField} ASC";
              break;
            case GrammarModes.grammarPoints:
              query = "SELECT * FROM ${GrammarTableFields.grammarTable} "
                  "ORDER BY ${GrammarTableFields.dateLastShownGrammarPointField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else if (type == Tests.less) {
        if (mode != null) {
          switch (mode) {
            case GrammarModes.definition:
              query = "SELECT * FROM ${GrammarTableFields.grammarTable} "
                  "ORDER BY ${GrammarTableFields.winRateDefinitionField} ASC";
              break;
            case GrammarModes.grammarPoints:
              query = "SELECT * FROM ${GrammarTableFields.grammarTable} "
                  "ORDER BY ${GrammarTableFields.winRateGrammarPointField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else {
        query = "SELECT * FROM ${GrammarTableFields.grammarTable}";
      }

      List<Map<String, dynamic>>? res = await _database.rawQuery(query);
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<GrammarPoint>> getArchiveGrammarPoints(
      {int? offset, int? limit}) async {
    try {
      List<Map<String, dynamic>>? res = await _database.query(
          GrammarTableFields.grammarTable,
          orderBy: "${GrammarTableFields.dateAddedField} DESC",
          limit: limit,
          offset: (offset != null && limit != null) ? (offset * limit) : null);
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
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
  Future<List<GrammarPoint>> getDailySM2GrammarPoints(GrammarModes mode) async {
    try {
      String query = "";
      String newestGrammarPointsQuery = "";
      final controlledPace =
          _preferencesRepository.readData(SharedKeys.dailyTestOnControlledPace);
      int limit =
          _preferencesRepository.readData(SharedKeys.numberOfKanjiInTest);

      if (controlledPace) {
        // Divide number of total words of the user's db by the weekdays
        limit =
            ((await _database.query(GrammarTableFields.grammarTable)).length /
                    7)
                .ceil();

        // Also check if the daily test can be performed
        switch (mode) {
          case GrammarModes.definition:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.definitionDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
          case GrammarModes.grammarPoints:
            final canBePerformed = _preferencesRepository
                .readData(SharedKeys.grammarPointDailyPerformed);
            if (canBePerformed != 0 && canBePerformed != null) return [];
            break;
        }
      }

      // We order by previousIntervalAsDate DESC, as we want to prioratize
      // early previous reviews rather than older ones.
      //
      // If we have pending review A since the day before yesterday and
      // fresh review B from yesterday, in this way B will be prioritized
      // over A.
      final today = DateTime.now().millisecondsSinceEpoch;
      switch (mode) {
        case GrammarModes.definition:
          query = "SELECT * FROM ${GrammarTableFields.grammarTable} "
              "WHERE ${GrammarTableFields.previousIntervalAsDateDefinitionField} <= $today "
              "ORDER BY ${GrammarTableFields.previousIntervalAsDateDefinitionField} DESC, "
              "${GrammarTableFields.winRateDefinitionField} ASC, "
              "${GrammarTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestGrammarPointsQuery =
              "SELECT * FROM ${GrammarTableFields.grammarTable} "
              "WHERE ${GrammarTableFields.previousIntervalAsDateDefinitionField} == 0 "
              "ORDER BY ${GrammarTableFields.winRateDefinitionField} ASC, "
              "${GrammarTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
        case GrammarModes.grammarPoints:
          query = "SELECT * FROM ${GrammarTableFields.grammarTable} "
              "WHERE ${GrammarTableFields.previousIntervalAsDateGrammarPointField} <= $today "
              "ORDER BY ${GrammarTableFields.previousIntervalAsDateGrammarPointField} DESC, "
              "${GrammarTableFields.winRateGrammarPointField} ASC, "
              "${GrammarTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          newestGrammarPointsQuery =
              "SELECT * FROM ${GrammarTableFields.grammarTable} "
              "WHERE ${GrammarTableFields.previousIntervalAsDateGrammarPointField} == 0 "
              "ORDER BY ${GrammarTableFields.winRateGrammarPointField} ASC, "
              "${GrammarTableFields.dateAddedField} DESC "
              "LIMIT $limit";
          break;
      }
      final res = await _database.rawQuery(query);
      final newestGrammarPoints =
          await _database.rawQuery(newestGrammarPointsQuery);
      final list =
          List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
      final newestGrammarPointsList = List.generate(newestGrammarPoints.length,
          (i) => GrammarPoint.fromJson(newestGrammarPoints[i]));
      newestGrammarPointsList.addAll(list);
      final finalList =
          newestGrammarPointsList.toSet().toList().take(limit).toList();
      return finalList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<GrammarPoint> getGrammarPoint(String grammarPoint,
      {String? listName, String? definition}) async {
    try {
      assert((listName != null && definition == null) ||
          (listName == null && definition != null));
      List<Map<String, dynamic>> res = [];
      if (listName != null) {
        res = await _database.query(GrammarTableFields.grammarTable,
            where:
                "${GrammarTableFields.listNameField}=? AND ${GrammarTableFields.nameField}=?",
            whereArgs: [listName, grammarPoint]);
      } else if (definition != null) {
        res = await _database.query(GrammarTableFields.grammarTable,
            where:
                "${GrammarTableFields.definitionField}=? AND ${GrammarTableFields.nameField}=?",
            whereArgs: [definition, grammarPoint]);
      }
      return GrammarPoint.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return GrammarPoint.empty;
    }
  }

  @override
  Future<List<GrammarPoint>> getGrammarPointBasedOnSelectedLists(
      List<String> listNames) async {
    try {
      String whereClause = "";

      /// Build up the where clauses from the listName
      for (var x = 0; x < listNames.length; x++) {
        whereClause += "${GrammarTableFields.listNameField}=? OR ";
      }

      /// Clean up the String
      whereClause = whereClause.substring(0, whereClause.length - 4);
      List<Map<String, dynamic>>? res = await _database.query(
          GrammarTableFields.grammarTable,
          where: whereClause,
          whereArgs: listNames);
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<GrammarPoint>> getGrammarPointsMatchingQuery(String query,
      {String? listName, required int offset, required int limit}) async {
    try {
      List<Map<String, dynamic>> res = [];
      String whereClause = "";

      if (listName != null) {
        whereClause =
            "WHERE ${GrammarTableFields.listNameField} = '$listName' AND ";
      } else {
        whereClause = "WHERE ";
      }
      res = await _database.rawQuery("SELECT * "
          "FROM ${GrammarTableFields.grammarTable} "
          "$whereClause "
          "(${GrammarTableFields.nameField} LIKE '%$query%' "
          "OR ${GrammarTableFields.definitionField} LIKE '%$query%') "
          "ORDER BY ${GrammarTableFields.dateAddedField} ASC "
          "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<int>> getSM2ReviewGrammarPointsAsForToday() async {
    try {
      final prefs = _preferencesRepository;
      final controlledPace =
          prefs.readData(SharedKeys.dailyTestOnControlledPace);
      List<String> limitQuery =
          List.generate(GrammarModes.values.length, (_) => '');
      // Resets check on daily performed tests based on the ms on
      // the saved key and the next day's 00:00 ms.
      //
      // writingDailyPerformed stores the next day's 00:00 ms. If
      // now() ms is greater than writingDailyPerformed, it means that
      // the test is ready to be performed again --> thus saving 0ms.
      //
      // The value of writingDailyPerformed is updated in test_result_bloc.
      if (controlledPace) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final limit =
            ((await _database.query(GrammarTableFields.grammarTable)).length /
                    7)
                .ceil();

        final d = prefs.readData(SharedKeys.definitionDailyPerformed);
        if (d == null || (d != null && d <= now)) {
          prefs.saveData(SharedKeys.definitionDailyPerformed, 0);
          limitQuery[0] = "LIMIT $limit";
        }

        final g = prefs.readData(SharedKeys.grammarPointDailyPerformed);
        if (g == null || (g != null && g <= now)) {
          prefs.saveData(SharedKeys.grammarPointDailyPerformed, 0);
          limitQuery[1] = "LIMIT $limit";
        }
      }

      final definitionNotification =
          prefs.readData(SharedKeys.definitionDailyNotification);
      final grammarPointNotification =
          prefs.readData(SharedKeys.grammarPointDailyNotification);
      final today = DateTime.now().millisecondsSinceEpoch;

      final resDefinition = definitionNotification
          // If no limit has been set and we are in controlledPace mode
          // it means that there is no available tests for now.
          ? controlledPace && limitQuery[0].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${GrammarTableFields.definitionField} FROM ${GrammarTableFields.grammarTable} "
                  "WHERE ${GrammarTableFields.previousIntervalAsDateDefinitionField} <= $today "
                  "${limitQuery[0]}")
          : [];
      final resGrammarPoint = grammarPointNotification
          // If no limit has been set and we are in controlledPace mode
          // it means that there is no available tests for now.
          ? controlledPace && limitQuery[1].isEmpty
              ? []
              : await _database.rawQuery(
                  "SELECT ${GrammarTableFields.definitionField} FROM ${GrammarTableFields.grammarTable} "
                  "WHERE ${GrammarTableFields.previousIntervalAsDateGrammarPointField} <= $today "
                  "${limitQuery[1]}")
          : [];
      return [resDefinition.length, resGrammarPoint.length];
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<int> getTotalGrammarPointCount() async {
    try {
      List<Map<String, dynamic>>? res =
          await _database.query(GrammarTableFields.grammarTable);
      return res.length;
    } catch (err) {
      print(err.toString());
      return 0;
    }
  }

  @override
  Future<GrammarPoint> getTotalGrammarPointsWinRates() async {
    try {
      List<Map<String, dynamic>>? res =
          await _database.query(GrammarTableFields.grammarTable);
      List<GrammarPoint> gp =
          List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
      final int total = gp.length;
      double definition = 0, grammarPoints = 0;
      for (var point in gp) {
        definition += (point.winRateDefinition == DatabaseConstants.emptyWinRate
            ? 0
            : point.winRateDefinition);
        grammarPoints +=
            (point.winRateGrammarPoint == DatabaseConstants.emptyWinRate
                ? 0
                : point.winRateGrammarPoint);
      }
      return GrammarPoint(
        name: '',
        definition: '',
        listName: '',
        example: '',
        winRateDefinition: definition == 0 ? 0 : definition / total,
        winRateGrammarPoint: grammarPoints == 0 ? 0 : grammarPoints / total,
      );
    } catch (err) {
      print(err.toString());
      return GrammarPoint.empty;
    }
  }

  @override
  Batch? mergeGrammarPoints(Batch? batch, List<GrammarPoint> grammarPoints,
      ConflictAlgorithm conflictAlgorithm) {
    for (var gp in grammarPoints) {
      batch?.insert(GrammarTableFields.grammarTable, gp.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    return batch;
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
