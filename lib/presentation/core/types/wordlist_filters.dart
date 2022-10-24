import 'package:kanpractice/application/services/database/database_consts.dart';
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
        return ListTableFields.totalWinRateWritingField;
      case WordListFilters.reading:
        return ListTableFields.totalWinRateReadingField;
      case WordListFilters.recognition:
        return ListTableFields.totalWinRateRecognitionField;
      case WordListFilters.listening:
        return ListTableFields.totalWinRateListeningField;
      case WordListFilters.speaking:
        return ListTableFields.totalWinRateSpeakingField;
      case WordListFilters.all:
        return ListTableFields.lastUpdatedField;
      case WordListFilters.alphabetically:
        return ListTableFields.nameField;
    }
  }
}

class KanListFiltersUtils {
  static WordListFilters getFilterFrom(String f) {
    if (f == ListTableFields.lastUpdatedField) {
      return WordListFilters.all;
    } else if (f == ListTableFields.nameField) {
      return WordListFilters.alphabetically;
    } else if (f == ListTableFields.totalWinRateWritingField) {
      return WordListFilters.writing;
    } else if (f == ListTableFields.totalWinRateReadingField) {
      return WordListFilters.reading;
    } else if (f == ListTableFields.totalWinRateRecognitionField) {
      return WordListFilters.recognition;
    } else if (f == ListTableFields.totalWinRateListeningField) {
      return WordListFilters.listening;
    } else {
      return WordListFilters.speaking;
    }
  }
}
