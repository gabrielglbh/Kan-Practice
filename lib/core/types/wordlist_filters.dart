import 'package:kanpractice/core/database/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum WordListFilters {
  all,
  alphabetically,
  writing,
  reading,
  recognition,
  listening,
  speaking
}

extension KanListFiltersExtensions on WordListFilters {
  String get label {
    switch (this) {
      case WordListFilters.all:
        return "filters_all".tr();
      case WordListFilters.alphabetically:
        return "ABC";
      case WordListFilters.writing:
        return "${"study_modes_writing".tr()} %";
      case WordListFilters.reading:
        return "${"study_modes_reading".tr()} %";
      case WordListFilters.recognition:
        return "${"study_modes_recognition".tr()} %";
      case WordListFilters.listening:
        return "${"study_modes_listening".tr()} %";
      case WordListFilters.speaking:
        return "${"study_modes_speaking".tr()} %";
    }
  }

  String get filter {
    switch (this) {
      case WordListFilters.writing:
        return KanListTableFields.totalWinRateWritingField;
      case WordListFilters.reading:
        return KanListTableFields.totalWinRateReadingField;
      case WordListFilters.recognition:
        return KanListTableFields.totalWinRateRecognitionField;
      case WordListFilters.listening:
        return KanListTableFields.totalWinRateListeningField;
      case WordListFilters.speaking:
        return KanListTableFields.totalWinRateSpeakingField;
      case WordListFilters.all:
        return KanListTableFields.lastUpdatedField;
      case WordListFilters.alphabetically:
        return KanListTableFields.nameField;
    }
  }
}

class KanListFiltersUtils {
  static WordListFilters getFilterFrom(String f) {
    if (f == KanListTableFields.lastUpdatedField) {
      return WordListFilters.all;
    } else if (f == KanListTableFields.nameField) {
      return WordListFilters.alphabetically;
    } else if (f == KanListTableFields.totalWinRateWritingField) {
      return WordListFilters.writing;
    } else if (f == KanListTableFields.totalWinRateReadingField) {
      return WordListFilters.reading;
    } else if (f == KanListTableFields.totalWinRateRecognitionField) {
      return WordListFilters.recognition;
    } else if (f == KanListTableFields.totalWinRateListeningField) {
      return WordListFilters.listening;
    } else {
      return WordListFilters.speaking;
    }
  }
}
