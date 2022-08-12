import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/core/routing/pages.dart';

enum StudyModes { writing, reading, recognition, listening, speaking }

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
      case StudyModes.speaking:
        return "study_modes_speaking".tr();
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
      case StudyModes.speaking:
        return "study_modes_speaking_ext".tr();
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
      case StudyModes.speaking:
        return Colors.brown.shade300;
    }
  }

  String get page {
    switch (this) {
      case StudyModes.writing:
        return KanPracticePages.writingStudyPage;
      case StudyModes.reading:
        return KanPracticePages.readingStudyPage;
      case StudyModes.recognition:
        return KanPracticePages.recognitionStudyPage;
      case StudyModes.listening:
        return KanPracticePages.listeningStudyPage;
      case StudyModes.speaking:
        return KanPracticePages.speakingStudyPage;
    }
  }
}

class StudyModesUtil {
  /// Maps the integer received from the source to a StudyModes. Based on [map]
  static StudyModes mapStudyMode(int map) => StudyModes.values[map];
}
