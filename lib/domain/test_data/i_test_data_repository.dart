import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';

abstract class ITestDataRepository {
  /// Merges Test Data Stats from the backup
  Future<int> mergeTestData(TestData data);
}
