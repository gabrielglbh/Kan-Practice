import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class ITestDataRepository {
  /// Merges Test Data Stats from the backup
  Batch? mergeTestData(
    Batch? batch,
    TestData data,
    ConflictAlgorithm conflictAlgorithm,
  );
  Future<void> insertExampleData();
  Future<TestData> getTestDataFromDb();
  Future<void> updateStats(Test test);

  /// Updates the initial map with the total writing tests, the total writing
  /// accuracy and the total tests accuracy using N*C + C' / N'
  Map<String, num> getAdditionalParams(TestData curr, Test test);

  /// Updates the count on test performed
  Map<String, num> getTestParams(TestData curr, Test test);
}
