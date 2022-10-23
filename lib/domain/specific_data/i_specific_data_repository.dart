import 'package:kanpractice/domain/specific_data/specific_data.dart';

abstract class ITestDataRepository {
  /// Merges words from the backup
  Future<int> mergeSpecificData(List<SpecificData> data);
}
