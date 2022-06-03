import 'package:kanpractice/core/database/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum KanListFilters { all, writing, reading, recognition, listening }

extension KanListFiltersExtensions on KanListFilters {
  String get label {
    switch (this) {
      case KanListFilters.all:
        return "filters_all".tr();
      case KanListFilters.writing:
        return "${"study_modes_writing".tr()} %";
      case KanListFilters.reading:
        return "${"study_modes_reading".tr()} %";
      case KanListFilters.recognition:
        return "${"study_modes_recognition".tr()} %";
      case KanListFilters.listening:
        return "${"study_modes_listening".tr()} %";
    }
  }

  String get filter {
    switch (this) {
      case KanListFilters.writing:
        return KanListTableFields.totalWinRateWritingField;
      case KanListFilters.reading:
        return KanListTableFields.totalWinRateReadingField;
      case KanListFilters.recognition:
        return KanListTableFields.totalWinRateRecognitionField;
      case KanListFilters.listening:
        return KanListTableFields.totalWinRateListeningField;
      case KanListFilters.all:
        return KanListTableFields.lastUpdatedField;
    }
  }
}

class KanListFiltersUtils {
  static KanListFilters getFilterFrom(String f) {
    if (f == KanListTableFields.lastUpdatedField) {
      return KanListFilters.all;
    } else if (f == KanListTableFields.totalWinRateWritingField) {
      return KanListFilters.writing;
    } else if (f == KanListTableFields.totalWinRateReadingField) {
      return KanListFilters.reading;
    } else if (f == KanListTableFields.totalWinRateRecognitionField) {
      return KanListFilters.recognition;
    } else {
      return KanListFilters.listening;
    }
  }
}
