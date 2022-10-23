import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';

abstract class ITestRepository {
  /// Creates a [Test] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createTest(Test test);

  /// Removes all tests from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeTests();
  Future<List<Test>> getTests(
    DateTime initial,
    DateTime last,
    TestFilters testFilter,
    StudyModeFilters modesFilter,
  );
  Future<List<Test>> getAllTests();
  Future<SpecificData> getSpecificTestData(Tests mode);
  Future<void> insertInitialTestData();
  Future<TestData> getTestDataFromDb();
  Future<void> updateStats(Test test);

  /// Updates the initial map with the total writing tests, the total writing
  /// accuracy and the total tests accuracy using N*C + C' / N'
  Map<String, num> getAdditionalParams(TestData curr, Test test);

  /// Updates the count on test performed
  Map<String, num> getTestParams(TestData curr, Test test);

  /// Updates the [test] specific stats using N*C + C' / N'
  Future<void> updateSpecificTestStats(Test test);
}
