import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

enum StudyModeFilters {
  all,
  writing,
  reading,
  recognition,
  listening,
  speaking
}

extension StudyModeFiltersExt on StudyModeFilters {
  String get mode {
    switch (this) {
      case StudyModeFilters.all:
        return "all_filter".tr();
      case StudyModeFilters.writing:
        return "study_modes_writing".tr();
      case StudyModeFilters.reading:
        return "study_modes_reading".tr();
      case StudyModeFilters.recognition:
        return "study_modes_recognition".tr();
      case StudyModeFilters.listening:
        return "study_modes_listening".tr();
      case StudyModeFilters.speaking:
        return "study_modes_speaking".tr();
    }
  }

  Color get color {
    switch (this) {
      case StudyModeFilters.all:
        return KPColors.accentLight;
      case StudyModeFilters.writing:
        return Colors.blue.shade300;
      case StudyModeFilters.reading:
        return Colors.purple.shade300;
      case StudyModeFilters.recognition:
        return Colors.orange.shade300;
      case StudyModeFilters.listening:
        return Colors.green.shade300;
      case StudyModeFilters.speaking:
        return Colors.red.shade200;
    }
  }
}
