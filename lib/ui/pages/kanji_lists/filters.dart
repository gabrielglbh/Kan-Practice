import 'package:kanpractice/core/database/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum KanListFilters { all, writing, reading, recognition }

extension KanListFiltersExtensions on KanListFilters {
  String get label {
    switch (this) {
      case KanListFilters.all:
        return "filters_all".tr();
      case KanListFilters.writing:
        return "filters_writing".tr();
      case KanListFilters.reading:
        return "filters_reading".tr();
      case KanListFilters.recognition:
        return "filters_recognition".tr();
    }
  }

  String get filter {
    switch (this) {
      case KanListFilters.writing:
        return totalWinRateWritingField;
      case KanListFilters.reading:
        return totalWinRateReadingField;
      case KanListFilters.recognition:
        return totalWinRateRecognitionField;
      case KanListFilters.all:
      default:
        return lastUpdatedField;
    }
  }
}