import 'package:kanpractice/domain/alter_specific_data/alter_specific_data.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IAlterSpecificDataRepository {
  /// Merges words from the backup
  Batch? mergeAlterSpecificData(
    Batch? batch,
    List<AlterSpecificData> data,
    ConflictAlgorithm conflictAlgorithm,
  );
  Future<AlterSpecificData> getAlterSpecificTestData(Tests mode);

  /// Updates the [test] specific stats using N*C + C' / N'
  Future<void> updateAlterSpecificTestStats(Test test);
}
