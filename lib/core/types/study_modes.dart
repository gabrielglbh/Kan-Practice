import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum StudyModes { writing, reading, recognition, listening }

extension StudyModesExt on StudyModes {
  String get mode {
    switch (this) {
      case StudyModes.writing:
        return "study_modes_writing".tr();
      case StudyModes.reading:
        return "study_modes_reading".tr();
      case StudyModes.recognition:
        return "study_modes_recognition".tr();
      case StudyModes.listening:
        return "study_modes_listening".tr();
    }
  }

  String get japMode {
    switch (this) {
      case StudyModes.writing:
        return "study_modes_writing_ext".tr();
      case StudyModes.reading:
        return "study_modes_reading_ext".tr();
      case StudyModes.recognition:
        return "study_modes_recognition_ext".tr();
      case StudyModes.listening:
        return "study_modes_listening_ext".tr();
    }
  }

  Color get color {
    switch (this) {
      case StudyModes.writing:
        return Colors.blue.shade300;
      case StudyModes.reading:
        return Colors.purple.shade300;
      case StudyModes.recognition:
        return Colors.orange.shade300;
      case StudyModes.listening:
        return Colors.green.shade300;
    }
  }
}

class StudyModesUtil {
  /// Maps the integer received from the source to a StudyModes. Based on [map]
  static StudyModes mapStudyMode(int map) => StudyModes.values[map];
}
