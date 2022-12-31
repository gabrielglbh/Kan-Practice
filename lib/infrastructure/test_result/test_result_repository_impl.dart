import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes_filters.dart';
import 'package:kanpractice/presentation/core/types/test_filters.dart';
import 'package:kanpractice/domain/test_result/i_test_repository.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: ITestRepository)
class TestResultRepositoryImpl implements ITestRepository {
  final Database _database;

  TestResultRepositoryImpl(this._database);

  @override
  Future<int> createTest(Test test) async {
    try {
      await _database.insert(TestTableFields.testTable, test.toJson());
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<List<Test>> getAllTests() async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database.query(TestTableFields.testTable);
      return List.generate(res.length, (i) => Test.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Test>> getTests(DateTime initial, DateTime last,
      TestFilters testFilter, TestModeFilters modesFilter) async {
    try {
      final initialMs = initial.millisecondsSinceEpoch;
      final lastMs = last.millisecondsSinceEpoch;
      String testFilterQuery = "";
      String modeFilterQuery = "";

      if (testFilter != TestFilters.all) {
        testFilterQuery =
            "AND ${TestTableFields.testModeField} == ${testFilter.index - 1}";
      }

      if (modesFilter != TestModeFilters.all) {
        // For the filters, the GrammarModes and StudyModes are sequentialized
        // Just remove the offset of the filter and apply the correct query
        if (modesFilter.index > StudyModes.values.length) {
          final realIndex = modesFilter.index - 1 - StudyModes.values.length;
          modeFilterQuery =
              "AND ${TestTableFields.grammarModeField} == $realIndex";
        } else {
          modeFilterQuery =
              "AND ${TestTableFields.studyModeField} == ${modesFilter.index - 1}";
        }
      }

      List<Map<String, dynamic>>? res = await _database.rawQuery(
        "SELECT * FROM ${TestTableFields.testTable} "
        "WHERE ${TestTableFields.takenDateField} >= $initialMs "
        "AND ${TestTableFields.takenDateField} <= $lastMs $testFilterQuery $modeFilterQuery",
      );
      return List.generate(res.length, (i) => Test.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<int> removeTests() async {
    try {
      await _database.delete(TestTableFields.testTable);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
