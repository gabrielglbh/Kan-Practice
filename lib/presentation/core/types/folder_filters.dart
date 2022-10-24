import 'package:kanpractice/application/services/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum FolderFilters { all, alphabetically }

extension FolderFiltersExtensions on FolderFilters {
  String get label {
    switch (this) {
      case FolderFilters.all:
        return "filters_all".tr();
      case FolderFilters.alphabetically:
        return "ABC";
    }
  }

  String get filter {
    switch (this) {
      case FolderFilters.all:
        return FolderTableFields.lastUpdatedField;
      case FolderFilters.alphabetically:
        return FolderTableFields.nameField;
    }
  }
}

class FolderFiltersUtils {
  static FolderFilters getFilterFrom(String f) {
    if (f == FolderTableFields.lastUpdatedField) {
      return FolderFilters.all;
    } else {
      return FolderFilters.alphabetically;
    }
  }
}
