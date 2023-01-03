import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class ISpecificDataRepository {
  /// Merges words from the backup
  Batch? mergeSpecificData(
    Batch? batch,
    List<SpecificData> data,
    ConflictAlgorithm conflictAlgorithm,
  );
  Future<SpecificData> getSpecificTestData(Tests mode);

  /// Updates the [test] specific stats using N*C + C' / N'
  Future<void> updateSpecificTestStats(Test test);
  Future<SpecificData> getSpecificCategoryData(WordCategory mode);
}
