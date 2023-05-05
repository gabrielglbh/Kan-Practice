import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/alter_specific_data/alter_specific_data.dart';
import 'package:kanpractice/domain/alter_specific_data/i_alter_specific_data_repository.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IAlterSpecificDataRepository)
class AlterAlterSpecificDataRepositoryImpl
    implements IAlterSpecificDataRepository {
  static const categoryId = -9999;
  final Database _database;

  AlterAlterSpecificDataRepositoryImpl(this._database);

  @override
  Future<AlterSpecificData> getAlterSpecificTestData(Tests mode) async {
    try {
      final res = await _database.query(
        AlterTestSpecificDataTableFields.testDataTable,
        where: "${AlterTestSpecificDataTableFields.idField}=?",
        whereArgs: [mode.index],
      );
      return AlterSpecificData.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return AlterSpecificData.empty;
    }
  }

  @override
  Batch? mergeAlterSpecificData(
    Batch? batch,
    List<AlterSpecificData> data,
    ConflictAlgorithm conflictAlgorithm,
  ) {
    for (int x = 0; x < data.length; x++) {
      batch?.insert(
          AlterTestSpecificDataTableFields.testDataTable, data[x].toJson(),
          conflictAlgorithm: conflictAlgorithm);
    }
    return batch;
  }

  // TODO: Update when adding a TEST such as number
  @override
  Future<void> updateAlterSpecificTestStats(Test test) async {
    final raw = await getAlterSpecificTestData(Tests.values[test.testMode!]);

    if (raw != AlterSpecificData.empty) {
      late Map<String, num> map;

      if (test.testMode == Tests.numbers.index) {
        final count = raw.totalNumberTestCount + 1;
        map = {
          AlterTestSpecificDataTableFields.totalNumberTestCountField: count,
          AlterTestSpecificDataTableFields.totalWinRateNumberTestField:
              ((raw.totalWinRateNumberTest * raw.totalNumberTestCount) +
                      test.testScore) /
                  count
        };
      } else if (test.testMode == Tests.translation.index) {
        final count = raw.totalTranslationTestCount + 1;
        map = {
          AlterTestSpecificDataTableFields.totalTranslationTestCountField:
              count,
          AlterTestSpecificDataTableFields.totalWinRateTranslationTestField:
              ((raw.totalWinRateTranslationTest *
                          raw.totalTranslationTestCount) +
                      test.testScore) /
                  count
        };
      }

      await _database.update(
        AlterTestSpecificDataTableFields.testDataTable,
        map,
        where: "${AlterTestSpecificDataTableFields.idField}=?",
        whereArgs: [raw.id],
      );
    } else {
      await _database.insert(
        AlterTestSpecificDataTableFields.testDataTable,
        AlterSpecificData(
          id: test.testMode!,
          totalNumberTestCount: test.testMode == Tests.numbers.index ? 1 : 0,
          totalTranslationTestCount:
              test.testMode == Tests.translation.index ? 1 : 0,
          totalWinRateNumberTest:
              test.testMode == Tests.numbers.index ? test.testScore : 0,
          totalWinRateTranslationTest:
              test.testMode == Tests.translation.index ? test.testScore : 0,
        ).toJson(),
      );
    }
  }
}
