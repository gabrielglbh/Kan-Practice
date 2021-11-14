import 'package:kanpractice/core/database/database_consts.dart';

enum KanListFilters { all, writing, reading, recognition }

extension KanListFiltersExtensions on KanListFilters {
  String get label {
    switch (this) {
      case KanListFilters.all:
        return "Last Created";
      case KanListFilters.writing:
        return "Writing %";
      case KanListFilters.reading:
        return "Reading %";
      case KanListFilters.recognition:
        return "Recognition %";
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