import 'package:kanpractice/application/services/database_consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum WordListFilters {
  all,
  recentlyAdded,
  alphabetically,
  writing,
  reading,
  recognition,
  listening,
  speaking,
  definition,
  grammarPoint
}

extension KanListFiltersExtensions on WordListFilters {
  String get label {
    switch (this) {
      case WordListFilters.all:
        return "filters_all".tr();
      case WordListFilters.recentlyAdded:
        return "filter_recently_added".tr();
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
      case WordListFilters.definition:
        return "${"study_modes_definition".tr()} %";
      case WordListFilters.grammarPoint:
        return "${"study_modes_grammarPoint".tr()} %";
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
      case WordListFilters.recentlyAdded:
        return WordTableFields.dateAddedField;
      case WordListFilters.definition:
        return ListTableFields.totalWinRateDefinitionField;
      case WordListFilters.grammarPoint:
        return ListTableFields.totalWinRateGrammarPointField;
    }
  }
}

class KanListFiltersUtils {
  static WordListFilters getFilterFrom(String f) {
    if (f == ListTableFields.lastUpdatedField) {
      return WordListFilters.all;
    } else if (f == WordTableFields.dateAddedField) {
      return WordListFilters.recentlyAdded;
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
    } else if (f == ListTableFields.totalWinRateSpeakingField) {
      return WordListFilters.speaking;
    } else if (f == ListTableFields.totalWinRateDefinitionField) {
      return WordListFilters.definition;
    } else {
      return WordListFilters.grammarPoint;
    }
  }
}
