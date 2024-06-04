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
  Future<void> updateStats(Test test, double elapsedTimeSecondsPerCard);

  /// Updates the initial map with the total writing tests, the total writing
  /// accuracy and the total tests accuracy using N*C + C' / N'
  Map<String, num> getAdditionalParams(
      TestData curr, Test test, double elapsedTimeSecondsPerCard);

  /// Updates the count on test performed
  Map<String, num> getTestParams(TestData curr, Test test);

  /// Removes all test data stats from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeTestData();
}
