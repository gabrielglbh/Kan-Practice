import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';
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
}
