import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

enum TestModeFilters {
  all,
  writing,
  reading,
  recognition,
  listening,
  speaking,
  definition,
  grammarPoint,
}

extension StudyModeFiltersExt on TestModeFilters {
  String get mode {
    switch (this) {
      case TestModeFilters.all:
        return "all_filter".tr();
      case TestModeFilters.writing:
        return "study_modes_writing".tr();
      case TestModeFilters.reading:
        return "study_modes_reading".tr();
      case TestModeFilters.recognition:
        return "study_modes_recognition".tr();
      case TestModeFilters.listening:
        return "study_modes_listening".tr();
      case TestModeFilters.speaking:
        return "study_modes_speaking".tr();
      case TestModeFilters.definition:
        return "study_modes_definition".tr();
      case TestModeFilters.grammarPoint:
        return "study_modes_grammarPoints".tr();
    }
  }

  Color get color {
    switch (this) {
      case TestModeFilters.all:
        return KPColors.accentLight;
      case TestModeFilters.writing:
        return Colors.blue.shade300;
      case TestModeFilters.reading:
        return Colors.purple.shade300;
      case TestModeFilters.recognition:
        return Colors.orange.shade300;
      case TestModeFilters.listening:
        return Colors.green.shade300;
      case TestModeFilters.speaking:
        return Colors.red.shade200;
      case TestModeFilters.definition:
        return Colors.indigo.shade300;
      case TestModeFilters.grammarPoint:
        return Colors.pink.shade300;
    }
  }
}
