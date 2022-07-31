import 'package:kanpractice/core/database/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum FolderFilters { all }

extension FolderFiltersExtensions on FolderFilters {
  String get label {
    switch (this) {
      case FolderFilters.all:
        return "filters_all".tr();
    }
  }

  String get filter {
    switch (this) {
      case FolderFilters.all:
        return FolderTableFields.lastUpdatedField;
    }
  }
}

class FolderFiltersUtils {
  static FolderFilters getFilterFrom(String f) {
    return FolderFilters.all;
  }
}
