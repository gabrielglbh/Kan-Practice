import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum StudyModes { writing, reading, recognition, listening }

extension StudyModesExt on StudyModes {
  String get mode {
    switch(this) {
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
    switch(this) {
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
    switch(this) {
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

  int get map {
    switch(this) {
      case StudyModes.writing:
        return 0;
      case StudyModes.reading:
        return 1;
      case StudyModes.recognition:
        return 2;
      case StudyModes.listening:
        return 3;
    }
  }
}

class StudyModesUtil {
  /// Maps the integer received from the source to a StudyModes. Based on [map]
  static StudyModes mapStudyMode(int map) {
    switch(map) {
      case 0:
        return StudyModes.writing;
      case 1:
        return StudyModes.reading;
      case 2:
        return StudyModes.recognition;
      case 3:
      default:
        return StudyModes.listening;
    }
  }
}