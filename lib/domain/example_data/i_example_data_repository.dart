import 'package:flutter/material.dart';

abstract class IExampleDataRepository {
  /// Sets the initial KanLists on first app view. The initial KanLists
  /// and their words are extracted from: assets/initialData/en.json
  Future<int> setInitialDataForReference(BuildContext context);
}
